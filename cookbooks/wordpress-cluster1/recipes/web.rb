#
#
# Cookbook Name:: wordpress-cluster1
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

include_recipe 'bedrock1::web'
include_recipe 'bedrock2::web'

csync2 = Chef::DataBagItem.load('csync2', 'key')

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
