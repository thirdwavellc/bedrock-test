# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

CHEF_JSON = {
  capistrano_base: {
    app_name: 'bedrock_test',
    db: {
      name: 'bedrock_test',
      environments: ['production']
    }
  }
}

CHEF_JSON_PROD = CHEF_JSON.merge!({
  capistrano_wordpress: {
    home: 'http://192.168.33.11',
    siteurl: 'http://192.168.33.11/wp'
  },
  ssh_import_id: {
    users: [
      {
        name: 'deploy',
        github_accounts: %w{adamkrone}
      }
    ]
  }
})

CHEF_JSON_MULTI_TENANT = CHEF_JSON.merge!({
  consul: {
    service_mode: 'client',
    service_user: 'root',
    service_group: 'root',
    servers: ['172.20.20.10', '172.20.20.11', '172.20.20.12'],
    bind_interface: 'eth1',
    bind_addr: '192.168.33.10',
    datacenter: 'vagrant'
  },
  consul_template: {
    consul: '127.0.0.1:8500',
    templates: [
      {
        source: '/var/www/bedrock1/shared/.env.ctmpl',
        destination: '/var/www/bedrock1/shared/.env'
      }
    ]
  },
  ssh_import_id: {
    users: [{name: 'deploy', github_accounts: %w{adamkrone}}]
  }
})

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-14.04"

  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :production do |prod|
    prod.vm.hostname = "bedrock-test.prod"
    prod.vm.network "private_network", ip: "192.168.33.11"

    config.vm.provision "chef_solo" do |chef|
      chef.data_bags_path = "data_bags"
      chef.add_recipe "chef-solo-search::default"
      chef.add_recipe "git::default"
      chef.add_recipe "capistrano-wordpress::all-in-one-role"
      chef.add_recipe "ssh-import-id::default"

      chef.json = CHEF_JSON_PROD
    end
  end

  config.vm.define 'multi-tenant' do |dev|
    dev.vm.hostname = "bedrock-multi-tenant.dev"
    dev.hostsupdater.aliases = ["bedrock1.dev", "bedrock2.dev"]
    dev.vm.network "private_network", ip: "192.168.33.10"

    dev.vm.provision "chef_solo" do |chef|
      chef.data_bags_path = "data_bags"
      chef.add_recipe "apt::default"
      chef.add_recipe "git::default"
      chef.add_recipe "chef-solo-search::default"
      chef.add_recipe "bedrock1::production"
      chef.add_recipe "bedrock2::production"
      chef.add_recipe "ssh-import-id::default"
      chef.add_recipe "consul::default"
      chef.add_recipe "consul-services::apache2"
      chef.add_recipe "consul-services::mysql"
      chef.add_recipe "consul-template::default"

      chef.json = CHEF_JSON_MULTI_TENANT
    end
  end
end
