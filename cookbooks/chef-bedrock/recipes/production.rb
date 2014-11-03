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
include_recipe 'capistrano-base::user'
include_recipe 'capistrano-base::ssh'
include_recipe 'capistrano-base::nodejs'
include_recipe 'capistrano-wordpress::php'
include_recipe 'capistrano-wordpress::composer'
include_recipe 'capistrano-wordpress::apache2'

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
