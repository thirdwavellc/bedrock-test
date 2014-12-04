#
# Cookbook Name:: bedrock
# Recipe:: lsyncd
#
# Copyright (C) 2014
#
#
#

node.normal['lsyncd']['watched_dirs'] = ['/var/www/bedrock/shared/web/app/uploads']

include_recipe 'lsyncd::default'
