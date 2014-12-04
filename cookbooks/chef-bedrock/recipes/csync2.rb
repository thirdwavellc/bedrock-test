#
# Cookbook Name:: bedrock
# Recipe:: csync2
#
# Copyright (C) 2014
#
#
#

include_recipe 'csync2::default'

# TODO: Move into data bag
cookbook_file 'csync2.key' do
  path '/etc/csync2.key'
  action :create_if_missing
end

csync2_config '/etc/csync2.cfg' do
  hosts [
    {name: 'bedrock01', ip_address: '192.168.33.11'},
    {name: 'bedrock02', ip_address: '192.168.33.12'},
    {name: 'bedrock03', ip_address: '192.168.33.13'}
  ]
end
