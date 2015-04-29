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
puppet module install puppetlabs/apache
puppet module install puppetlabs/mysql
puppet module install example42/php
puppet module install saz/timezone
puppet module install jproyo/git
puppet module install tPl0ch/composer --ignore-dependencies
puppet module install willdurand/nodejs

echo "Applying manifests..."
puppet apply puppet/manifests/site.pp --modulepath puppet/modules:/etc/puppet/modules

echo "Complete!"