#
# Cookbook Name:: bedrock2
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

mysql = Chef::DataBagItem.load('mysql', 'root')

wordpress_cluster_database 'bedrock2_production' do
  user 'bedrock2'
  user_host '%'
  user_password 'bedrock2'
  mysql_root_password mysql['password']
end
