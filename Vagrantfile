# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative './key_authorization'

VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"
    config.ssh.forward_agent = true
    config.vm.network :private_network, ip: "192.168.56.10"
    config.vm.hostname = "gravityapple.dev"

    authorize_key_for_root config, '~/.ssh/id_dsa.pub', '~/.ssh/id_rsa.pub'

    if Vagrant.has_plugin? 'vagrant-hostsupdater'
      config.hostsupdater.aliases = ["www.gravityapple.dev"]
    else
      raise Vagrant::Errors::VagrantError.new,
        "vagrant-hostsupdater missing, please install the plugin:\nvagrant plugin install vagrant-hostsupdater"
    end 

    config.vm.synced_folder "./www", "/usr/share/nginx/html", 
      group: 'www-data', 
      owner: 'www-data', 
      mount_options: ["dmode=777", "fmode=766"]

    config.vm.provider :virtualbox do |vb|
      vb.name = "gravityapple"
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.inventory_path = "ansible/hosts"
      ansible.limit = "dev"
    end

end