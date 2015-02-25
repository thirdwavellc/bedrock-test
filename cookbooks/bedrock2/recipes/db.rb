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
  datacenter 'vagrant'
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_bind_interface 'eth1'
end
