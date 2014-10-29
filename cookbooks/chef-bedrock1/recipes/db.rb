#
# Cookbook Name:: bedrock1
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

include_recipe 'capistrano-base::mysql-server'

capistrano_mysql 'bedrock1' do
  mysql_root_password node['mysql']['server_root_password']
  db_user 'bedrock1'
  db_user_host '%'
  db_password 'bedrock1'
  db_environments ['production']
end
