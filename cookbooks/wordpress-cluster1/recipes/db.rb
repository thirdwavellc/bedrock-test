#
# Cookbook Name:: wordpress-cluster1
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

mysql = Chef::DataBagItem.load('mysql', 'root')

consul_cluster_client 'vagrant' do
  servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  bind_interface 'eth1'
end

service 'consul'

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
