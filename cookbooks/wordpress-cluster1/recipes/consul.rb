#
#
# Cookbook Name:: wordpress-cluster1
# Recipe:: consul
#
# Copyright (C) 2014
#
#
#

consul_acl = Chef::DataBagItem.load('consul', 'acl')

consul_cluster_client 'vagrant' do
  servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  bind_interface 'eth1'
  acl_datacenter 'vagrant'
  acl_token consul_acl['token']
end

service 'consul'
