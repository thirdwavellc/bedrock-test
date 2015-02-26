#
# Cookbook Name:: wordpress-cluster1
# Recipe:: haproxy-backup
#
# Copyright (C) 2014
#
#
#

keepalived = Chef::DataBagItem.load('keepalived', 'auth')
consul_acl = Chef::DataBagItem.load('consul', 'acl')

consul_cluster_client 'vagrant' do
  servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  bind_interface 'eth1'
  acl_datacenter 'vagrant'
  acl_token consul_acl['token']
end

service 'consul'

wordpress_cluster_lb 'BACKUP' do
  keepalived_priority '100'
  keepalived_virtual_ip '172.20.10.10'
  keepalived_interface 'eth1'
  keepalived_auth_pass keepalived['password']
  sites [{ name: 'consul', host: 'consul.stg', service: 'consul-ui@vagrant', basic_auth: true },
         { name: 'bedrock1', host: 'bedrock1.stg', service: 'apache2@vagrant'},
         { name: 'bedrock2', host: 'bedrock2.stg', service: 'apache2@vagrant'}]
  basic_auth_users [{ username: 'consul', password: 'consul' }]
end

include_recipe 'consul-services::haproxy'
include_recipe 'consul-services::consul-template'
include_recipe 'consul-services::keepalived'
