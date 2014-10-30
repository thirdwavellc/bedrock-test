#
# Cookbook Name:: bedrock
# Recipe:: cron
#
# Copyright (C) 2014
#
#
#

include_recipe 'cron::default'

cron_d 'sync-bedrock-0' do
  command '/usr/sbin/csync2 -x'
  user    'root'
end

cron_d 'sync-bedrock-15' do
  command 'sleep 15; /usr/sbin/csync2 -x'
  user    'root'
end

cron_d 'sync-bedrock-30' do
  command 'sleep 30; /usr/sbin/csync2 -x'
  user    'root'
end

cron_d 'sync-bedrock-45' do
  command 'sleep 45; /usr/sbin/csync2 -x'
  user    'root'
end
