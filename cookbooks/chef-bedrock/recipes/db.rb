#
# Cookbook Name:: bedrock
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

mysql = Chef::DataBagItem.load('mysql', 'root')
node.override['mysql']['server_root_password'] = mysql['password']

directory '/etc/mysql/conf.d'

template '/etc/mysql/conf.d/wordpress-tuning.cnf' do
  source 'wordpress-tuning.cnf.erb'
  action :create
end

wordpress_cluster_db 'production' do
  app_name 'bedrock'
  user 'bedrock'
  user_host '%'
  user_password 'bedrock'
  mysql_root_password node['mysql']['server_root_password']
  datacenter 'vagrant'
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
end
