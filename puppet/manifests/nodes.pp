node 'local-gravityapple' {

    apache::vhost { 'local-gravityapple.com': 
        port           => '80',
        docroot        => "/home/www/gravityapple/public/",
        docroot_owner  => 'www-data',
        docroot_group  => 'www-data',
        serveradmin    => 'gravityapple@gmail.com',
        serveraliases  => [
            'www.local-gravityapple.com',
        ],
    }

    apache::vhost { 'snappad.local-gravityapple.com': 
        port           => '80',
        docroot        => "/home/www/snap-pad/public/",
        docroot_owner  => 'www-data',
        docroot_group  => 'www-data',
        serveradmin    => 'gravityapple@gmail.com',
    }

    usercreate::create { 'vagrant':
        comment => 'Vagrant user',
        groups  => ['cdrom', 'sudo', 'audio', 'video'],
    }

}

node 'gravityapple' {

    apache::vhost { 'gravityapple.com': 
        port           => '80',
        docroot        => "/home/www/gravityapple/public/",
        docroot_owner  => 'www-data',
        docroot_group  => 'www-data',
        serveradmin    => 'gravityapple@gmail.com',
        serveraliases  => [
            'www.gravityapple.com',
        ],
    }

    apache::vhost { 'snappad.gravityapple.com': 
        port           => '80',
        docroot        => "/home/www/snap-pad/public/",
        docroot_owner  => 'www-data',
        docroot_group  => 'www-data',
        serveradmin    => 'gravityapple@gmail.com',
    }

    include ssh
}