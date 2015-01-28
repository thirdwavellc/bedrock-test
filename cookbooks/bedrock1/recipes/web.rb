#
# Cookbook Name:: bedrock
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

consul_acl = Chef::DataBagItem.load('consul', 'acl')

wordpress_cluster_app 'bedrock1' do
  server_name 'bedrock1.stg'
  scm 'git'
  github_accounts ['adamkrone']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token consul_acl['token']
  datacenter 'vagrant'
end
