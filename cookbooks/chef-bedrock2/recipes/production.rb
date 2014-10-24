#
# Cookbook Name:: bedrock2
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

capistrano_app 'bedrock2' do
  template 'web_app.conf.erb'
  deploy_root '/var/www/bedrock2'
  docroot '/var/www/bedrock2/current/web'
  deployment_user 'deploy'
  deployment_group 'deploy'
  server_name 'bedrock2.dev'
end

template_variables = {
  environment_variables: {
    DB_NAME: 'bedrock2_production',
    DB_USER: 'bedrock2',
    DB_PASSWORD: 'bedrock2',
    DB_HOST: 'localhost',
    WP_ENV: 'production',
    WP_HOME: 'http://bedrock2.dev',
    WP_SITEURL: 'http://bedrock2.dev/wp'
  }
}

capistrano_shared_file '.env' do
  path '/var/www/bedrock2/shared'
  template '.env.erb'
  variables template_variables
  owner 'deploy'
  group 'deploy'
end

include_recipe 'capistrano-base::mysql-server'

capistrano_mysql 'bedrock2' do
  mysql_root_password node['mysql']['server_root_password']
  db_user 'bedrock2'
  db_password 'bedrock2'
  db_environments ['production']
end
