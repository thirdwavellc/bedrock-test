#
# Cookbook Name:: bedrock
# Recipe:: web
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

node.normal['ssh_import_id'] = {
  users: [
    {
      name: 'deploy',
      github_accounts: ['adamkrone']
    }
  ]
}

include_recipe 'ssh-import-id::default'
