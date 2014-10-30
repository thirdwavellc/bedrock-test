# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

CHEF_JSON_PROD = {
  ssh_import_id: {
    users: [
      {
        name: 'deploy',
        github_accounts: %w{adamkrone}
      }
    ]
  }
}

NUMBER_NODES = 3

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-14.04"

  config.omnibus.chef_version = :latest

  1.upto(NUMBER_NODES) do |num|
    name = "bedrock0#{num}"
    config.vm.define name do |node|
      node.vm.hostname = "#{name}.dev"
      node.vm.network "private_network", ip: "192.168.33.#{10 + num}"

      node.vm.provision "chef_solo" do |chef|
        chef.data_bags_path = "data_bags"
        chef.add_recipe "chef-solo-search::default"
        chef.add_recipe "git::default"
        chef.add_recipe "bedrock::production"
        chef.add_recipe "bedrock::csync2"
        chef.add_recipe "bedrock::lsyncd"
        chef.add_recipe "ssh-import-id::default"

        chef.json = CHEF_JSON_PROD
      end
    end
  end

  config.vm.define 'db' do |db|
    db.vm.hostname = 'db.bedrock.dev'
    db.vm.network "private_network", ip: "192.168.33.20"

    db.vm.provision "chef_solo" do |chef|
      chef.add_recipe "apt::default"
      chef.add_recipe "bedrock::db"
    end
  end

  config.vm.define 'haproxy' do |haproxy|
    haproxy.vm.hostname = 'bedrock.dev'
    haproxy.vm.network "private_network", ip: "192.168.33.10"

    haproxy.vm.provision "chef_solo" do |chef|
      chef.add_recipe "apt::default"
      chef.add_recipe "bedrock::haproxy"
    end
  end
end
