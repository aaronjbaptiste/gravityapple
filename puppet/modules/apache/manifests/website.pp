define apache::website ($site_domain) {

    include apache
    include mysql
    include php

    $site_name = $name
    $base_dir = "/home/www/${site_name}"
    $public_dir = "${base_dir}/public"

    file { '/etc/apache2/sites-enabled/000-default':
        ensure => absent,
    }

    file { "/etc/apache2/sites-enabled/${$site_name}.conf":
        content => template('apache/vhost.conf.erb'),
        notify  => Service['apache2'],
        require => Package['apache2'],
    }

    file { ['/home/www/',
            $base_dir,
            "${base_dir}/cgi-bin",
            "${base_dir}/log",
            $public_dir]:
        ensure => directory,
    }

}