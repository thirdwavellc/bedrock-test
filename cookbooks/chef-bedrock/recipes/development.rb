#
# Cookbook Name:: bedrock
# Recipe:: development
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'

wordpress_cluster_app 'bedrock' do
  deployment_user 'vagrant'
  deployment_group 'vagrant'
  server_name 'bedrock.dev'
  development true
end

include_recipe 'mysql::server'

capistrano_mysql_database 'development' do
  app_name 'bedrock'
  user 'bedrock'
  user_password 'bedrock'
  mysql_root_password node['mysql']['server_root_password']
end
