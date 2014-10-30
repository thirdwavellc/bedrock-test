#
# Cookbook Name:: bedrock
# Recipe:: lsyncd
#
# Copyright (C) 2014
#
#
#

package 'lsyncd'

template '/etc/lsyncd.conf' do
  source 'lsyncd.conf.erb'
  action :create
end

template '/etc/init.d/lsyncd' do
  source 'lsyncd.init.erb'
  action :create
end

service 'lsyncd' do
  supports start: true, stop: true, restart: true, status: true
  action [:enable, :start]
end
