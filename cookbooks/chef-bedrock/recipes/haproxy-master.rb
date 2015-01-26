#
# Cookbook Name:: bedrock
# Recipe:: haproxy-master
#
# Copyright (C) 2014
#
#
#

node.normal['varnish']['version'] = '3.0.5'
node.normal['varnish']['listen_port'] = 80
node.normal['varnish']['vcl_cookbook'] = 'bedrock'

include_recipe 'varnish::default'

keepalived = Chef::DataBagItem.load('keepalived', 'auth')
consul_acl = Chef::DataBagItem.load('consul', 'acl')

wordpress_cluster_lb '101' do
  keepalived_state 'MASTER'
  keepalived_virtual_ip '172.20.10.10'
  keepalived_interface 'eth1'
  keepalived_auth_pass keepalived['password']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_acl['token']
  datacenter 'vagrant'
end
