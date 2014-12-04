#
# Cookbook Name:: bedrock
# Recipe:: production
#
# Copyright (C) 2014
#
#
#

node.override['apache2']['mpm'] = 'prefork'

include_recipe 'apt::default'
include_recipe "git::default"
include_recipe 'capistrano-base::user'
include_recipe 'capistrano-base::ssh'
include_recipe 'capistrano-base::nodejs'
include_recipe 'capistrano-wordpress::php'
include_recipe 'capistrano-wordpress::composer'
include_recipe 'capistrano-wordpress::apache2'

apache_module "mpm_event" do
  enable false
end

apache_module "mpm_prefork"

capistrano_app 'bedrock' do
  template 'web_app.conf.erb'
  deploy_root '/var/www/bedrock'
  docroot '/var/www/bedrock/current/web'
  deployment_user 'deploy'
  deployment_group 'deploy'
  server_name 'bedrock.dev'
end

capistrano_shared_file '.env.ctmpl' do
  path '/var/www/bedrock/shared'
  template '.env.ctmpl.erb'
  owner 'deploy'
  group 'deploy'
end

include_recipe "bedrock::csync2"
include_recipe "bedrock::lsyncd"
include_recipe "ssh-import-id::default"
include_recipe "consul::default"
include_recipe "consul-services::apache2"
include_recipe "consul-services::consul-template"
include_recipe "consul-services::lsyncd"

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
