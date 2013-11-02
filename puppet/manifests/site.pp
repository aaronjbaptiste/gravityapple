stage { 'pre':
    before => Stage['main'],
}

stage { 'last':
    require => Stage['main'],
}

#update package list before doing anything with Packages
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
}
Exec['apt-update'] -> Package <| |>

#users
include sudoers
usercreate::create { 'aaron':
    comment => 'Aaron John-Baptiste',
    groups  => ['sudo'],
}

#lamp stack
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

class { 'timezone':
    timezone => 'Europe/London',
}

include iptables

package { 'vim':
    ensure => installed,
}

class { 'updatedb':
    stage => last,
}

#import node specific stuff
import 'nodes.pp'