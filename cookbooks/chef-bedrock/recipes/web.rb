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

node.override['apache']['prefork']['startservers'] = 64
node.override['apache']['prefork']['minspareservers'] = 64
node.override['apache']['prefork']['maxspareservers'] = 128
node.override['apache']['prefork']['serverlimit'] = 256
node.override['apache']['prefork']['maxrequestworkers'] = 256
node.override['apache']['prefork']['maxconnectionsperchild'] = 10_000

wordpress_cluster_app 'bedrock' do
  server_name 'bedrock.prod'
  scm 'git'
  github_accounts ['adamkrone']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_acl['token']
  datacenter 'vagrant'
  csync2_hosts [
    {name: 'web01', ip_address: '172.20.10.11'},
    {name: 'web02', ip_address: '172.20.10.12'},
    {name: 'web03', ip_address: '172.20.10.13'}
  ]
  csync2_key csync2['key']
  lsyncd_watched_dirs ['/var/www/bedrock/shared/web/app/uploads']
end
