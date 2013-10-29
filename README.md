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

### Setting up on a freshly created Debian 7 Host (untested on other distributions)

Login and change root password:

```bash
passwd
```

Update:

```bash
apt-get update && apt-get upgrade -y
```

If Hosting provider doesn't already setup hostname:

```bash
sudo hostname gravityapple
sudo su -c 'echo gravityapple > /etc/hostname'
#replace ip address with ip of machine
sudo su -c 'echo 127.0.0.1 gravityapple.com >> /etc/hosts'
```

Install puppet:

```bash
wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get update
apt-get -y install puppet
rm puppetlabs-release-wheezy.deb
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

Provision:

```bash
cd gravityapple/puppet
puppet apply ./manifests/site.pp --modulepath ./modules
```

All done!

Todo
----

1. Set hostname via puppet