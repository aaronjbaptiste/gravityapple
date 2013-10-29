class tzdata {

    exec { 'update timezone':
        command => '/bin/echo "Europe/London" > /etc/timezone && \
            /usr/sbin/dpkg-reconfigure -f noninteractive tzdata',
        unless  => '/bin/cat /etc/timezone | grep "Europe/London"',
    }

}