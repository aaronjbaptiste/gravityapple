gravityapple
============

The personal website of [Aaron John-Baptiste](http://gravityapple.com). 

It contains the fully automated provisioning and deployment of www.gravityapple.com and the sub-domain snappad.gravityapple.com as well as vagrant development environments - gravityapple.dev and snappad.gravityapple.dev

### To setup dev environment

Host machine prerequisites:

1. [Install Ansible](http://docs.ansible.com/intro_installation.html#running-from-source)
2. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. [Install Vagrant](http://downloads.vagrantup.com)
4. Install useful Vagrant plugins:

```bash
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostsupdater
```

Checkout code:

```bash
git clone https://github.com/aaronjbaptiste/gravityapple.git gravityapple
cd gravityapple
```

Configure:

```
cp ansible/group_vars/secrets.sample ansible/group_vars/all/secrets
```

Edit files:

1. ansible/hosts
2. ansible/group_vars/all/config
3. ansible/group_vars/all/secrets

Boot:

```bash
vagrant up
```

All done, check out [http://gravityapple.dev]!

### Then, to setup production (Ubuntu 14.04 x64 LTS)

Prereq:

root ssh access via ssh key on port 22

Initial setup:

```
ansible-playbook ansible/playbook.yml -l production -uroot -e ansible_ssh_port=22 -i ansible/hosts
```

To update:

```
ansible-playbook ansible/playbook.yml -l production --ask-sudo-pass -udeploy -i ansible/hosts
```