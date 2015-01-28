#
# Cookbook Name:: wordpress-cluster1
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

include_recipe 'bedrock1::db'
include_recipe 'bedrock2::db'
