# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

NUMBER_WEB_SERVERS = 3
NUMBER_LOAD_BALANCERS = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/ubuntu-14.04'

  config.omnibus.chef_version = :latest

  config.vm.define 'dev' do |dev|
    dev.vm.hostname = 'bedrock.dev'
    dev.vm.network 'private_network', ip: '172.20.10.9'
    dev.vm.synced_folder './', '/var/www/bedrock/current'

    dev.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock::development'
    end
  end

  1.upto(NUMBER_WEB_SERVERS).each do |num|
    config.vm.define "staging-web-0#{num}" do |web|
      web.vm.hostname = "web0#{num}.bedrock.stg"
      web.vm.network 'private_network', ip: "172.20.10.#{10 + num}"

      web.vm.provider 'virtualbox' do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      web.vm.provision 'chef_solo' do |chef|
        chef.data_bags_path = 'data_bags'
        chef.add_recipe 'chef-solo-search::default'
        chef.add_recipe 'bedrock::web'
      end
    end
  end

  config.vm.define 'staging-db' do |db|
    db.vm.hostname = 'db.bedrock.stg'
    db.vm.network 'private_network', ip: '172.20.10.20'

    db.vm.provider 'virtualbox' do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end

    db.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'bedrock::db'
    end
  end

  1.upto(NUMBER_LOAD_BALANCERS).each do |num|
    config.vm.define "staging-lb-0#{num}" do |lb|
      lb.vm.hostname = "lb0#{num}.bedrock.stg"
      lb.vm.network 'private_network', ip: "172.20.10.#{100 + num}"

      lb.vm.provider 'virtualbox' do |vb|
        vb.memory = 512
        vb.cpus = 1
      end

      lb.vm.provision 'chef_solo' do |chef|
        chef.data_bags_path = 'data_bags'
        if num == 1
          chef.add_recipe 'bedrock::haproxy-master'
        else
          chef.add_recipe 'bedrock::haproxy-backup'
        end
      end
    end
  end
end
