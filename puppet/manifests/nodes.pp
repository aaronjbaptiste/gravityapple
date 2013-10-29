stage { 'last':
    require => Stage['main'],
}

stage { 'pre':
    before => Stage['main'],
}

class { 'updatedb':
    stage => last,
}

class { 'tzdata':
    stage => pre,
}

node 'local-gravityapple' {

    apache::website { $name:
        site_domain => 'local-gravityapple.com',
    }

    include updatedb
    include iptables

    package { 'vim':
        ensure => installed,
    }

    usercreate::create { 'vagrant':
        comment => 'Vagrant user',
        groups  => ['cdrom', 'sudo', 'audio', 'video'],
    }

}

node 'gravityapple' {

    apache::website { $name:
        site_domain => 'gravityapple.com',
    }

    include ssh
    include sudoers
    include updatedb
    include iptables

    package { 'vim':
        ensure => installed,
    }

    usercreate::create { 'aaron':
        comment => 'Aaron John-Baptiste',
        groups  => ['sudo'],
    }

}