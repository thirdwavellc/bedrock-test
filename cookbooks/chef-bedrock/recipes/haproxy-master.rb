#
# Cookbook Name:: bedrock
# Recipe:: haproxy-master
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_lb '101' do
  keepalived_state 'MASTER'
  keepalived_virtual_ip '192.168.33.10'
  keepalived_interface 'eth1'
  keepalived_auth_pass 'mypass'
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  consul_acl_datacenter 'vagrant'
  consul_acl_token '3a6efcc8-b0e5-93e8-9188-b7cda829b929'
  datacenter 'vagrant'
end
