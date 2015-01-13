#
# Cookbook Name:: bedrock
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock' do
  server_name 'bedrock.prod'
  scm 'git'
  ssh_import_ids ['adamkrone']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token '3a6efcc8-b0e5-93e8-9188-b7cda829b929'
  datacenter 'vagrant'
  csync2_hosts [
    {name: 'web01', ip_address: '192.168.33.11'},
    {name: 'web02', ip_address: '192.168.33.12'}
  ]
  csync2_key 'a5HuyFhmKThg.aOS_iNr8N_UOMvp6VLd.AnSL.PvP5SzckPpEYyMaWDP2Jv5t2H6'
  lsyncd_watched_dirs ['/var/www/bedrock/shared/web/app/uploads']
end
