#
# Cookbook Name:: bedrock
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

include_recipe "apt::default"
include_recipe 'capistrano-base::mysql-server'

capistrano_mysql 'bedrock' do
  mysql_root_password node['mysql']['server_root_password']
  db_user 'bedrock'
  db_user_host '%'
  db_password 'bedrock'
  db_environments ['production']
end

include_recipe "consul::default"
include_recipe "consul-services::mysql"
