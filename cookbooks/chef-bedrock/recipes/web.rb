#
# Cookbook Name:: bedrock
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

consul_acl = Chef::DataBagItem.load('consul', 'acl')
csync2 = Chef::DataBagItem.load('csync2', 'key')

wordpress_cluster_app 'bedrock' do
  server_name 'bedrock.prod'
  scm 'git'
  github_accounts ['adamkrone']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_acl['token']
  datacenter 'vagrant'
  csync2_hosts [
    {name: 'web01', ip_address: '192.168.33.11'},
    {name: 'web02', ip_address: '192.168.33.12'}
  ]
  csync2_key csync2['key']
  lsyncd_watched_dirs ['/var/www/bedrock/shared/web/app/uploads']
end
