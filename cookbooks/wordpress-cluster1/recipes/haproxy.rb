#
# Cookbook Name:: wordpress-cluster1
# Recipe:: haproxy
#
# Copyright (C) 2014
#
#
#

keepalived = Chef::DataBagItem.load('keepalived', 'auth')

wordpress_cluster_lb node['wordpress-cluster1']['keepalived']['state'] do
  keepalived_priority node['wordpress-cluster1']['keepalived']['priority']
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
