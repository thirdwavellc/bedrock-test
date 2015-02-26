#
#
# Cookbook Name:: wordpress-cluster1
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'

consul_acl = Chef::DataBagItem.load('consul', 'acl')
csync2 = Chef::DataBagItem.load('csync2', 'key')

consul_cluster_client 'vagrant' do
  servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  bind_interface 'eth1'
  acl_datacenter 'vagrant'
  acl_token consul_acl['token']
end

service 'consul'

# Site recipes
include_recipe 'bedrock1::web'
include_recipe 'bedrock2::web'

wordpress_cluster_repl_config 'main' do
  csync2_key csync2['key']
  csync2_hosts [
    {name: 'web01', ip_address: '172.20.10.11'},
    {name: 'web02', ip_address: '172.20.10.12'}
  ]
  synced_dirs [
    '/var/www/bedrock1/shared/web/app/uploads',
    '/var/www/bedrock2/shared/web/app/uploads'
  ]
end

include_recipe 'consul-services::apache2'
include_recipe 'consul-services::consul-template'
