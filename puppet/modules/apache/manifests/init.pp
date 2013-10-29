class apache {

    package { 'apache2':
        ensure => installed,
    }

    service { 'apache2':
        ensure      => running,
        hasrestart  => true,
        enable      => true,
        require     => Package['apache2'],
    }

    exec {
        '/usr/sbin/a2enmod rewrite':
            unless  => '/bin/readlink -e /etc/apache2/mods-enabled/rewrite.load',
            notify  => Service['apache2'],
            require => Package['apache2'];
        '/usr/sbin/a2enmod expires':
            unless  => '/bin/readlink -e /etc/apache2/mods-enabled/expires.load',
            notify  => Service['apache2'],
            require => Package['apache2'];
    }

}