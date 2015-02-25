#
# Cookbook Name:: wordpress-cluster1
# Recipe:: haproxy-master
#
# Copyright (C) 2014
#
#
#

keepalived = Chef::DataBagItem.load('keepalived', 'auth')
consul_acl = Chef::DataBagItem.load('consul', 'acl')

wordpress_cluster_lb 'MASTER' do
  keepalived_priority '101'
  keepalived_virtual_ip '172.20.10.10'
  keepalived_interface 'eth1'
  keepalived_auth_pass keepalived['password']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_acl['token']
  datacenter 'vagrant'
  sites [{ name: 'consul', host: 'consul.stg', service: 'consul-ui', basic_auth: true },
         { name: 'bedrock1', host: 'bedrock1.stg', service: 'varnish'},
         { name: 'bedrock2', host: 'bedrock2.stg', service: 'varnish'}]
  basic_auth_users [{ username: 'consul', password: 'consul' }]
end
