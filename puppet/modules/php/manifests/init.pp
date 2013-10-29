class php {

    package { ['php5', 'php5-mysql', 'libapache2-mod-php5']:
        ensure => installed,
    }

    file { '/etc/php.init':
        ensure  => file,
        notify  => Service['apache2'],
        require => Package['php5'],
    }

}