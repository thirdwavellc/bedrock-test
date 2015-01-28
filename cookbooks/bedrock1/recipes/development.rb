#
# Cookbook Name:: bedrock1
# Recipe:: development
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock1' do
  deployment_user 'vagrant'
  deployment_group 'vagrant'
  server_name 'bedrock1.dev'
  development true
end

wordpress_cluster_db 'development' do
  app_name 'bedrock1'
  user 'bedrock1'
  user_password 'bedrock1'
  mysql_root_password node['mysql']['server_root_password']
  development true
end
