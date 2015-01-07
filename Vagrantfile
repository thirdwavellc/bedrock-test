# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/ubuntu-14.04'

  config.omnibus.chef_version = :latest

  config.vm.define 'dev' do |node|
    node.vm.hostname = 'bedrock.dev'
    node.vm.network 'private_network', ip: '192.168.33.9'
    node.vm.synced_folder './', '/var/www/bedrock/current'

    node.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock::development'
    end
  end

  config.vm.define 'staging-web' do |node|
    node.vm.hostname = 'bedrock.prod'
    node.vm.network 'private_network', ip: '192.168.33.10'

    node.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock::web'
    end
  end

  config.vm.define 'staging-db' do |db|
    db.vm.hostname = 'db.bedrock.dev'
    db.vm.network 'private_network', ip: '192.168.33.20'

    db.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'bedrock::db'
    end
  end
end
