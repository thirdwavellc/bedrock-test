#
# Cookbook Name:: bedrock
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'
include_recipe 'mysql::server'

capistrano_mysql_database 'production' do
  app_name 'bedrock'
  user 'bedrock'
  user_host '%'
  user_password 'bedrock'
  mysql_root_password node['mysql']['server_root_password']
end

include_recipe 'consul::default'
include_recipe 'consul-services::mysql'
