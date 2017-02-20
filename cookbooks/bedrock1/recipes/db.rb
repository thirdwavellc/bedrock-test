#
# Cookbook Name:: bedrock1
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

mysql = Chef::DataBagItem.load('mysql', 'root')

wordpress_cluster_database 'bedrock1_production' do
  user 'bedrock1'
  user_host '%'
  user_password 'bedrock1'
  mysql_root_password mysql['password']
end
