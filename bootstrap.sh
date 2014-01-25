if ! type "puppet" > /dev/null; then
    echo "Downloading puppet..."
    cd /home
    wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb

    echo "Installing puppet..."
    dpkg -i puppetlabs-release-wheezy.deb
    apt-get update
    apt-get -y install puppet
    rm puppetlabs-release-wheezy.deb
fi

echo "Installing puppet modules from the forge..."
cd /home/www/
puppet module install puppetlabs/apache --modulepath puppet/forge-modules
puppet module install puppetlabs/mysql --modulepath puppet/forge-modules
puppet module install example42/php --modulepath puppet/forge-modules
puppet module install saz/timezone --modulepath puppet/forge-modules
puppet module install jproyo/git --modulepath puppet/forge-modules
puppet module install tPl0ch/composer --modulepath puppet/forge-modules --ignore-dependencies
puppet module install willdurand/nodejs --modulepath puppet/forge-modules

echo "Applying manifests..."
puppet apply puppet/manifests/site.pp --modulepath puppet/modules:puppet/forge-modules

echo "Complete!"