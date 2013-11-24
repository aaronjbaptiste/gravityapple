###
### stages
###
stage { 'pre':
    before => Stage['main'],
}

stage { 'last':
    require => Stage['main'],
}

###
### house cleaning
###
#update package list before doing anything with Packages
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
}
Exec['apt-update'] -> Package <| |>

class { 'timezone':
    timezone => 'Europe/London',
}

include iptables

class { 'updatedb':
    stage => last,
}

package { 'vim':
    ensure => installed,
}

include git

###
### users
###
include sudoers
usercreate::create { 'aaron':
    comment => 'Aaron John-Baptiste',
    groups  => ['sudo'],
}

###
### lamp stack
###
class { 'apache': 
    default_vhost => false,
    sendfile      => 'off',
    mpm_module    => 'prefork',
}

include apache::mod::rewrite
include apache::mod::php 

class { '::mysql::server': ;
        '::mysql::client': ;
        'php': ;
}

php::module { "mcrypt": }
php::module { "mysql": }

###
### minecraft
###
file { '/opt/minecraft/server.properties':
    ensure  => file,
    owner   => 'mcserver',
    group   => 'mcserver',
    mode    => '0664',
    require => User['mcserver'],
}

class { 'minecraft': 
    heap_size  => 512,
    heap_start => 256,
    manage_curl => false,
}

S3file <| title == "${minecraft::homedir}/minecraft_server.jar" |> { 
    source  => 'Minecraft.Download/versions/1.7.2/minecraft_server.1.7.2.jar',
    require => Package['curl'],
}

Service <| title == 'minecraft' |> { 
    enable  => true,
}

minecraft::server_prop { 
    'server-name':  value => 'GravityApple';
    'difficulty':   value => 2;
    'max-players':  value => 8;
    'motd':         value => 'Yo yo yo!';
}

###
### snap-pad
###
git::repo{'snap-pad':
    path   => '/home/www/snap-pad',
    source => 'https://github.com/aaronjbaptiste/snap-pad.git',
}

include composer

class { 'nodejs':
  version => 'stable',
}

file { '/home/www/snap-pad/app/storage':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
    recurse => true,
    require => Git::Repo['snap-pad'],
}

composer::exec { 'snap-pad-install':
    cmd => 'install',
    cwd => '/home/www/snap-pad',
}

package { ['requirejs', 'bower']:
    provider => 'npm',
    ensure   => present,
    require => Class['nodejs'],
}

#bower install
exec { 'bower install':
    cwd     => "/home/www/snap-pad",
    command => "/usr/local/node/node-v0.10.22/bin/bower install --allow-root",
    require => Package['bower'],
}

###
### node specific stuff
###
import 'nodes.pp'