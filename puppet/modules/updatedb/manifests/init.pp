class updatedb {

    exec { 'update database':
        command => '/usr/bin/updatedb',
    }
   
}
