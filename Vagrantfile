# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.provision "chef_solo" do |chef|
    chef.data_bags_path = "data_bags"
    chef.add_recipe "chef-solo-search::default"
    chef.add_recipe "git::default"
    chef.add_recipe "capistrano-wordpress::all-in-one-role"
    chef.add_recipe "ssh-import-id::default"

    chef.json = {
      capistrano_wordpress: {
        app_name: 'bedrock_test',
        db: {
          name: 'bedrock_test',
          environments: ['production']
        },
        wp: {
          home: 'http://192.168.33.10',
          siteurl: 'http://192.168.33.10/wp'
        }
      },
      ssh_import_id: {
        users: [
          {
            name: 'deploy',
            github_accounts: %w{adamkrone}
          }
        ]
      }
    }
  end
end
