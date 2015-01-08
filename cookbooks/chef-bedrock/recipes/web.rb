#
# Cookbook Name:: bedrock
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

wordpress_cluster_app 'bedrock' do
  server_name 'bedrock.prod'
  scm 'git'
  ssh_import_ids ['adamkrone']
  consul_servers ['172.20.20.10', '172.20.20.11', '172.20.20.12']
  datacenter 'vagrant'
end
