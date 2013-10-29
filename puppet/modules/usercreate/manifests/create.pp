define usercreate::create($comment, $groups = []) {

    user { $name:
        ensure      => present,
        comment     => $comment,
        home        => "/home/${name}",
        managehome  => true,
        groups      => $groups,
        shell       => '/bin/bash',
    }

    ssh_authorized_key { "${name}_ssh":
        user    => $name,
        type    => 'rsa',
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDB2L9V5zUAaBj1UyoX80nOKMXMDGKCLFuIKtOeq+oY91DHBTS/6PSr0jzJt0YSaMCW5q9GmCvU5aIHOUoPuZdTJ+hAh8Ymnv9/UbavHC0+96rsU77kLgHi3w4rZVJemxa2MmFvcALjWww/HCHZgqcw/iWVTS8wefKFd+C+Lka+QhJz7lAbcljG/T/8czmf9m7yjajlbQYtXaYWWNbT2vI/g6Y6xO3OP8JlC3H6W63CW4i2X9M1Wz9dAWqJW7hEUAIiOll30MmUcrXnHx6sujAa86llfqeyaze8AM5CZ9ifUAr7xydZQhT5mgDoLu7WUqzzr/w58Z5h4/gfQwp5/dWh',
    }

    exec { "${name}_bashrc":
        command => "/bin/sed -i -e's/#force_color_prompt/force_color_prompt/' /home/${name}/.bashrc",
        unless  => "/bin/cat /home/${name}/.bashrc | grep -e '^force_color_prompt=yes'",
    }

}