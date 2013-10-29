class mysql {

    package { ['mysql-server', 'mysql-client']:
        ensure => installed,
    }

    service { 'mysql':
        ensure      => running,
        hasrestart  => true,
        enable      => true,
        require     => Package['mysql-server'],
    }

}