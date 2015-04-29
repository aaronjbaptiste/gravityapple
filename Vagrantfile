# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "debian-jessie"
  config.vm.box_url = "http://static.gender-api.com/debian-8-jessie-rc2-x64-slim.box"
  
  config.vm.hostname = "gravityapple"
  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true
  config.hostmanager.aliases = %w(gravityapple.dev)

  config.vm.synced_folder ".", "/home/www", id: "vagrant-root", :owner => "www-data", :group => "www-data"
  
  config.vm.network :private_network, ip: "192.168.85.13"
  
  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision "shell", path: "bootstrap.sh"
  
end
