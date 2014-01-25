gravityapple
============

The personal website and playground for [Aaron John-Baptiste](http://gravityapple.com). 

It contains fully automated provisioning of the website www.gravityapple.com and the sub-domain snappad.gravityapple.com.

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

All done, check out 192.168.85.13!

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
cd /home
git clone https://github.com/aaronjbaptiste/gravityapple.git www
```

Install:

```bash
chmod u+x bootstrap.sh
./bootstrap.sh
```

All done! Easy huh?

Todo
----

1. Look into puppet-librarian instead of listing puppet modules in bootstrap.sh
2. Automate hosts file (on the host) updating
3. Remove hack to run bower after https://github.com/willdurand/puppet-nodejs/pull/30