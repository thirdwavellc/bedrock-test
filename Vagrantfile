# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

GITHUB_ACCOUNTS = ['adamkrone']

CONSUL_CONFIG = {
  service_mode: 'client',
  service_user: 'root',
  service_group: 'root',
  servers: ['172.20.20.10', '172.20.20.11', '172.20.20.12'],
  bind_interface: 'eth1',
  datacenter: 'vagrant'
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/ubuntu-14.04'

  config.omnibus.chef_version = :latest

  config.vm.define 'dev' do |node|
    ip_address = '192.168.33.1'
    node.vm.hostname = 'bedrock.dev'
    node.vm.network 'private_network', ip: ip_address
    node.vm.synced_folder './', '/var/www/bedrock/current'

    node.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock::development'
    end
  end

  config.vm.define 'prod-web' do |node|
    ip_address = '192.168.33.10'
    node.vm.hostname = 'bedrock.prod'
    node.vm.network 'private_network', ip: ip_address

    node.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'
      chef.add_recipe 'chef-solo-search::default'
      chef.add_recipe 'bedrock::web_production'

      chef.json = {
        consul: CONSUL_CONFIG.merge({
          bind_addr: ip_address,
        }),
        ssh_import_id: {
          users: [
            {
              name: 'deploy',
              github_accounts: GITHUB_ACCOUNTS
            }
          ]
        }
      }
    end
  end

  config.vm.define 'prod-db' do |db|
    ip_address = '192.168.33.20'
    db.vm.hostname = 'db.bedrock.dev'
    db.vm.network 'private_network', ip: ip_address

    db.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'bedrock::db'

      chef.json = {
        consul: CONSUL_CONFIG.merge({
          bind_addr: ip_address,
        })
      }
    end
  end
end
