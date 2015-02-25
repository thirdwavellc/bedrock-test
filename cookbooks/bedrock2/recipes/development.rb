#
# Cookbook Name:: bedrock2
# Recipe:: development
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock2' do
  deployment_user 'vagrant'
  deployment_group 'vagrant'
  server_name 'bedrock2.dev'
  development true
end

wordpress_cluster_database 'bedrock2_development' do
  user 'bedrock2'
  user_password 'bedrock2'
  mysql_root_password node['mysql']['server_root_password']
  development true
end
