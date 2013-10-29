class sudoers {

    file { '/etc/sudo':
        source  => 'puppet:///modules/sudoers/sudoers',
        mode    => '0440',
        owner   => root,
        group   => root,
    }

}