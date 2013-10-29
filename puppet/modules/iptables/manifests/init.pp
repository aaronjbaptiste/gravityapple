class iptables {

    file { '/etc/init.d/firewallrules.sh':
        source  => 'puppet:///modules/iptables/firewallrules.sh',
        mode    => '0770',
        owner   => root,
        group   => root,
    }

    file { '/etc/rc.local':
        source  => 'puppet:///modules/iptables/rc.local',
        mode    => '0755',
        owner   => root,
        group   => root,
        require => File['/etc/init.d/firewallrules.sh'],
    }

    exec { 'update iptables':
        command     => '/etc/init.d/firewallrules.sh',
        refreshonly => true,
        subscribe   => File['/etc/init.d/firewallrules.sh'],
    }

}