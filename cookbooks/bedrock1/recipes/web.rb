#
# Cookbook Name:: bedrock
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock1' do
  server_name 'bedrock1.stg'
  scm 'git'
  github_accounts ['adamkrone']
end
