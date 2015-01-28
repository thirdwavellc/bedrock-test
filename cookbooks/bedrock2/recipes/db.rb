#
# Cookbook Name:: bedrock2
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

mysql = Chef::DataBagItem.load('mysql', 'root')
node.override['mysql']['server_root_password'] = mysql['password']

wordpress_cluster_db 'production' do
  app_name 'bedrock2'
  user 'bedrock2'
  user_host '%'
  user_password 'bedrock2'
  mysql_root_password node['mysql']['server_root_password']
  datacenter 'vagrant'
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
end
