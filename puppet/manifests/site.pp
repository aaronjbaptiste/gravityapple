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
    default_mods  => false,
    default_vhost => false,
    sendfile      => 'off',
}

include apache::mod::dir 


class { '::mysql::server': ;
        '::mysql::client': ;
        'php': ;
}

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
}

S3file <| title == "${minecraft::homedir}/minecraft_server.jar" |> { 
    source  => 'Minecraft.Download/versions/1.7.2/minecraft_server.1.7.2.jar'
}

Service <| title == 'minecraft' |> { 
    enable  => true
}

minecraft::server_prop { 
    'server-name':  value => 'GravityApple';
    'server-port':  value => 40962;
    'difficulty':   value => 2;
    'max-players':  value => 8;
    'motd':         value => 'All good in the hood!';
}

###
### node specific stuff
###
import 'nodes.pp'