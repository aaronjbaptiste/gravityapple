gravityapple
============

The personal website of [Aaron John-Baptiste](http://gravityapple.com). 

It contains the fully automated provisioning and deployment of www.gravityapple.com and the sub-domain snappad.gravityapple.com as well as vagrant development environments - gravityapple.dev and snappad.gravityapple.dev

### Step 1 - Setting up the development environment

Host machine prerequisites:

1. [Install Ansible](http://docs.ansible.com/intro_installation.html#running-from-source)
1. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Install Vagrant](http://downloads.vagrantup.com)
3. Install useful Vagrant plugins:

```bash
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-bindfs
```

Checkout code:

```bash
git clone https://github.com/aaronjbaptiste/gravityapple.git gravityapple & cd gravityapple
```

Edit files:

1. ansible/hosts - Change to your production ip
1. group_vars/all
    - Generate a password and add for the deploy user
    - logwatch email
1. group_vars/production 
    - Change sshd_port (any number between 1025 and 65536)
    - Change mysql_root_password
  

Boot and provision!:

```bash
vagrant up
```

All done, check out [http://gravityapple.dev]!

### Step 2 - Deploying

Prereq:

1. A host created and it's ip address is listed in ansible/hosts
1. You have ssh access to the host and ssh_user can login via a ssk key.

Run the following, replace ssh_user:

```
ansible-playbook playbook.yml -l production --ask-sudo-pass -u<ssh_user>
```

The above will disable root access over ssh but create a deloy user to use instead. Next time you need to push changes to production run the above with -udeploy