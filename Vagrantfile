# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

GITHUB_ACCOUNTS = ['adamkrone']

NUMBER_NODES = 3

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-14.04"

  config.omnibus.chef_version = :latest

  1.upto(NUMBER_NODES) do |num|
    name = "bedrock0#{num}"
    ip_address = "192.168.33.#{10 + num}"
    config.vm.define name do |node|
      node.vm.hostname = "#{name}.dev"
      node.vm.network "private_network", ip: ip_address

      node.vm.provision "chef_solo" do |chef|
        chef.data_bags_path = "data_bags"
        chef.add_recipe "chef-solo-search::default"
        chef.add_recipe "git::default"
        chef.add_recipe "bedrock::production"
        chef.add_recipe "bedrock::csync2"
        chef.add_recipe "bedrock::lsyncd"
        chef.add_recipe "ssh-import-id::default"
        chef.add_recipe "consul::default"
        chef.add_recipe "consul-services::apache2"
        chef.add_recipe "consul-services::consul-template"
        chef.add_recipe "consul-services::lsyncd"
        chef.add_recipe "consul-template::default"

        chef.json = {
          consul: {
            service_mode: 'client',
            service_user: 'root',
            service_group: 'root',
            servers: ['172.20.20.10', '172.20.20.11', '172.20.20.12'],
            bind_interface: 'eth1',
            bind_addr: ip_address,
            datacenter: 'vagrant'
          },
          consul_template: {
            consul: '127.0.0.1:8500',
            templates: [
              {
                source: '/var/www/bedrock/shared/.env.ctmpl',
                destination: '/var/www/bedrock/shared/.env'
              }
            ]
          },
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
  end

  config.vm.define 'db' do |db|
    db.vm.hostname = 'db.bedrock.dev'
    db.vm.network "private_network", ip: "192.168.33.20"

    db.vm.provision "chef_solo" do |chef|
      chef.add_recipe "apt::default"
      chef.add_recipe "bedrock::db"
      chef.add_recipe "consul::default"
      chef.add_recipe "consul-services::mysql"

      chef.json = {
        consul: {
          service_mode: 'client',
          service_user: 'root',
          service_group: 'root',
          servers: ['172.20.20.10', '172.20.20.11', '172.20.20.12'],
          bind_interface: 'eth1',
          bind_addr: '192.168.33.20',
          datacenter: 'vagrant'
        }
      }
    end
  end

  config.vm.define 'haproxy' do |haproxy|
    haproxy.vm.hostname = 'bedrock.dev'
    haproxy.vm.network "private_network", ip: "192.168.33.10"

    haproxy.vm.provision "chef_solo" do |chef|
      chef.add_recipe "apt::default"
      chef.add_recipe "bedrock::haproxy"
      chef.add_recipe "consul::default"
      chef.add_recipe "consul-services::haproxy"

      chef.json = {
        consul: {
          service_mode: 'client',
          service_user: 'root',
          service_group: 'root',
          servers: ['172.20.20.10', '172.20.20.11', '172.20.20.12'],
          bind_interface: 'eth1',
          bind_addr: '192.168.33.10',
          datacenter: 'vagrant'
        }
      }
    end
  end
end
