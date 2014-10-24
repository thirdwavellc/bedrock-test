#
# Cookbook Name:: bedrock1
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

capistrano_app 'bedrock1' do
  template 'web_app.conf.erb'
  deploy_root '/var/www/bedrock1'
  docroot '/var/www/bedrock1/current/web'
  deployment_user 'deploy'
  deployment_group 'deploy'
  server_name 'bedrock1.dev'
end

template_variables = {
  environment_variables: {
    DB_NAME: 'bedrock1_production',
    DB_USER: 'bedrock1',
    DB_PASSWORD: 'bedrock1',
    DB_HOST: 'localhost',
    WP_ENV: 'production',
    WP_HOME: 'http://bedrock1.dev',
    WP_SITEURL: 'http://bedrock1.dev/wp'
  }
}

capistrano_shared_file '.env' do
  path '/var/www/bedrock1/shared'
  template '.env.erb'
  variables template_variables
  owner 'deploy'
  group 'deploy'
end

include_recipe 'capistrano-base::mysql-server'

capistrano_mysql 'bedrock1' do
  mysql_root_password node['mysql']['server_root_password']
  db_user 'bedrock1'
  db_password 'bedrock1'
  db_environments ['production']
end
