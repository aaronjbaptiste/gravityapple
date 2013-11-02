gravityapple
============

The personal website and playground for [Aaron John-Baptiste](http://gravityapple.com). 

### Setting up locally

Host machine prerequisites:

1. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Install Vagrant](http://downloads.vagrantup.com)

Checkout code:

```bash
git clone https://github.com/aaronjbaptiste/gravityapple.git gravityapple
```

Boot and provision!:

```bash
cd gravityapple
vagrant up
```

All done, check out 192.168.85.6!

### Setting up on a freshly created Debian 7 Host (untested on other distributions)

Login and change root password:

```bash
passwd
```

Update:

```bash
apt-get update && apt-get upgrade -y
```

Install git:

```bash
apt-get install -y git
```

Checkout code:

```bash
mkdir /home/www && cd /home/www
git clone https://github.com/aaronjbaptiste/gravityapple.git gravityapple
```

Install:

```bash
cd gravityapple
./boostrap.sh
```

All done! Easy huh?

Todo
----

1. Look into puppet-librarian instead of listing puppet modules in bootstrap.sh