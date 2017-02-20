#
# Cookbook Name:: wordpress-cluster1
# Recipe:: haproxy-master
#
# Copyright (C) 2014
#
#
#

include_recipe 'wordpress-cluster1::consul'

node.normal['wordpress-cluster1']['keepalived']['state'] = 'MASTER'
node.normal['wordpress-cluster1']['keepalived']['priority'] = '101'

include_recipe 'wordpress-cluster1::haproxy'
