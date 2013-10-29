# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "debian-70rc1-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"
  
  config.vm.hostname = "local-gravityapple"

  config.vm.synced_folder ".", "/home/www/local-gravityapple", nfs: true
  
  config.vm.network :forwarded_port, guest: 80, host: 1380
  config.vm.network :forwarded_port, guest: 22, host: 1322
  config.vm.network :private_network, ip: "192.168.85.6"
  
  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "puppet/modules"
    # puppet.options = "--verbose --debug"
  end
  
end
