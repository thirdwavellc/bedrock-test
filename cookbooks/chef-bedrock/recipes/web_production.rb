#
# Cookbook Name:: bedrock
# Recipe:: production
#
# Copyright (C) 2014
#
#
#

include_recipe 'apt::default'
include_recipe 'git::default'

wordpress_cluster_app 'bedrock' do
  server_name 'bedrock.prod'
end

include_recipe 'ssh-import-id::default'
