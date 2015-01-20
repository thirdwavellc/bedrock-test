#
# Cookbook Name:: bedrock
# Recipe:: haproxy-master
#
# Copyright (C) 2014
#
#
#

keepalived_data_bag = Chef::DataBagItem.load('keepalived', 'auth')
consul_data_bag = Chef::DataBagItem.load('consul', 'acl')

wordpress_cluster_lb '101' do
  keepalived_state 'MASTER'
  keepalived_virtual_ip '192.168.33.10'
  keepalived_interface 'eth1'
  keepalived_auth_pass keepalived_data_bag['password']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_data_bag['token']
  datacenter 'vagrant'
end
