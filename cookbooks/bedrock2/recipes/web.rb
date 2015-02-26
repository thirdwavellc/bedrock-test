#
# Cookbook Name:: bedrock2
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock2' do
  server_name 'bedrock2.stg'
  scm 'git'
  github_accounts ['adamkrone']
end
