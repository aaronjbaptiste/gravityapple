# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"
    config.ssh.forward_agent = true
    config.vm.network :private_network, ip: "192.168.56.10"
    config.vm.hostname = "gravityapple.dev"

    if Vagrant.has_plugin? 'vagrant-hostsupdater'
      config.hostsupdater.aliases = ["www.gravityapple.dev"]
    else
      raise Vagrant::Errors::VagrantError.new,
        "vagrant-hostsupdater missing, please install the plugin:\nvagrant plugin install vagrant-hostsupdater"
    end

    if Vagrant.has_plugin? 'vagrant-bindfs'
      config.vm.synced_folder './public', '/vagrant', type: 'nfs'
      config.bindfs.bind_folder '/vagrant', '/var/www/gravityapple', u: 'vagrant', g: 'www-data'
    else
      raise Vagrant::Errors::VagrantError.new,
        "vagrant-bindfs missing, please install the plugin:\nvagrant plugin install vagrant-bindfs"
    end

    config.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.inventory_path = "ansible/inventories/webhosts"
      ansible.limit = 'dev'
    end

    config.vm.provider :virtualbox do |vb|
      vb.name = "gravityapple"
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

end