#
# Cookbook Name:: bedrock
# Recipe:: production
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'
include_recipe "git::default"

capistrano_user 'deploy' do
  group 'deploy'
  group_id 3000
end

include_recipe 'capistrano-base::ssh'

capistrano_wordpress_app 'bedrock' do
  deploy_root '/var/www/bedrock'
  docroot '/var/www/bedrock/current/web'
  deployment_user 'deploy'
  deployment_group 'deploy'
  server_name 'bedrock.dev'
end

capistrano_shared_file '.env.ctmpl' do
  template '.env.ctmpl.erb'
  deploy_root '/var/www/bedrock'
  owner 'deploy'
  group 'deploy'
end

include_recipe "ssh-import-id::default"

include_recipe "consul::default"
include_recipe "consul-services::apache2"
include_recipe "consul-services::consul-template"

node.normal['consul_template'] = {
  consul: '127.0.0.1:8500'
}

include_recipe "consul-template::default"

consul_template_config 'bedrock_env' do
  templates [{
    source: '/var/www/bedrock/shared/.env.ctmpl',
    destination: '/var/www/bedrock/shared/.env'
  }]
end
