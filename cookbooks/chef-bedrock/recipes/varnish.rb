#
# Cookbook Name:: bedrock
# Recipe:: varnish
#
# Copyright (C) 2014
#
#
#

node.normal['varnish']['version'] = '3.0.5'
node.normal['varnish']['listen_port'] = 80
node.normal['varnish']['vcl_cookbook'] = 'bedrock'
node.normal['varnish']['ttl'] = 15

include_recipe 'varnish::default'
