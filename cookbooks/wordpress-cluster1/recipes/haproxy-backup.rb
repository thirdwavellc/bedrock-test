#
# Cookbook Name:: wordpress-cluster1
# Recipe:: haproxy-backup
#
# Copyright (C) 2014
#
#
#

include_recipe 'wordpress-cluster1::consul'

node.normal['wordpress-cluster1']['keepalived']['state'] = 'BACKUP'
node.normal['wordpress-cluster1']['keepalived']['priority'] = '100'

include_recipe 'wordpress-cluster1::haproxy'
