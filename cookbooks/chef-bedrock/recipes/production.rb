#
# Cookbook Name:: bedrock
# Recipe:: production
#
# Copyright (C) 2014
#
#
#

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

template_variables = {
  environment_variables: {
    DB_NAME: 'bedrock_production',
    DB_USER: 'bedrock',
    DB_PASSWORD: 'bedrock',
    DB_HOST: '192.168.33.20',
    WP_ENV: 'production',
    WP_HOME: 'http://bedrock.dev',
    WP_SITEURL: 'http://bedrock.dev/wp'
  }
}

capistrano_shared_file '.env' do
  path '/var/www/bedrock/shared'
  template '.env.erb'
  variables template_variables
  owner 'deploy'
  group 'deploy'
end
