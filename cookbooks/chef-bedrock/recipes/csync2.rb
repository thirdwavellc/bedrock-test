#
# Cookbook Name:: bedrock
# Recipe:: csync2
#
# Copyright (C) 2014
#
#
#

package 'csync2'

hosts = ['bedrock01', 'bedrock02', 'bedrock03']

template '/etc/csync2.cfg' do
  source 'csync2.cfg.erb'
  variables(
    hosts: hosts
  )
  action :create
end

hosts.each do |host|
  template "/etc/csync2_#{host}.cfg" do
    source 'csync2_node.cfg.erb'
    variables(
      group: host,
      hosts: hosts
    )
    action :create
  end
end

template '/etc/csync2.key' do
  source 'csync2.key.erb'
  action :create
end

hostsfile_entry '192.168.33.11' do
  hostname  'bedrock01'
  action    :create_if_missing
end

hostsfile_entry '192.168.33.12' do
  hostname  'bedrock02'
  action    :create_if_missing
end

hostsfile_entry '192.168.33.13' do
  hostname  'bedrock03'
  action    :create_if_missing
end
