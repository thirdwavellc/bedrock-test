#
# Cookbook Name:: wordpress-cluster1
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

include_recipe 'wordpress-cluster1::consul'

mysql = Chef::DataBagItem.load('mysql', 'root')

mysql_cluster 'cluster1' do
  node_ips ['172.20.10.21', '172.20.10.22', '172.20.10.23']
  bind_interface 'eth1'
  root_password mysql['password']
  debian_password mysql['password']
end

include_recipe 'consul-services::mysql'

# Site recipes
include_recipe 'bedrock1::db'
include_recipe 'bedrock2::db'
