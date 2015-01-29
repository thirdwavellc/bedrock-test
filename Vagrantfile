# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

NUMBER_WEB_SERVERS = 2
NUMBER_DB_SERVERS = 3
NUMBER_LOAD_BALANCERS = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/ubuntu-14.04'

  config.omnibus.chef_version = :latest

  config.vm.define 'dev' do |dev|
    dev.vm.hostname = 'bedrock1.dev'
    dev.vm.network 'private_network', ip: '172.20.10.9'
    dev.vm.synced_folder './', '/var/www/bedrock1/current'

    dev.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock1::development'
    end
  end

  1.upto(NUMBER_WEB_SERVERS).each do |num|
    config.vm.define "web0#{num}" do |web|
      web.vm.hostname = "web0#{num}.wp01.stg"
      web.vm.network 'private_network', ip: "172.20.10.#{10 + num}"

      web.vm.provider 'virtualbox' do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      web.vm.provision 'chef_solo' do |chef|
        chef.data_bags_path = 'data_bags'
        chef.add_recipe 'chef-solo-search::default'
        chef.add_recipe 'wordpress-cluster1::web'
      end
    end
  end

  1.upto(NUMBER_DB_SERVERS).each do |num|
    config.vm.define "db0#{num}" do |db|
      db.vm.hostname = "db0#{num}.wp01.stg"
      db.vm.network 'private_network', ip: "172.20.10.#{20 + num}"

      db.vm.provider 'virtualbox' do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      db.vm.provision 'chef_solo' do |chef|
        chef.data_bags_path = 'data_bags'
        chef.add_recipe 'wordpress-cluster1::db'
      end
    end
  end

  1.upto(NUMBER_LOAD_BALANCERS).each do |num|
    config.vm.define "lb0#{num}" do |lb|
      lb.vm.hostname = "lb0#{num}.wp01.stg"
      lb.vm.network 'private_network', ip: "172.20.10.#{100 + num}"

      lb.vm.provider 'virtualbox' do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      lb.vm.provision 'chef_solo' do |chef|
        chef.data_bags_path = 'data_bags'
        if num == 1
          chef.add_recipe 'wordpress-cluster1::haproxy-master'
        else
          chef.add_recipe 'wordpress-cluster1::haproxy-backup'
        end
      end
    end
  end
end
