#
# Cookbook Name:: bedrock
# Recipe:: haproxy
#
# Copyright (C) 2014
#
#
#

include_recipe "apt::default"
include_recipe "haproxy::install_package"

service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end

cookbook_file "/etc/default/haproxy" do
  cookbook "haproxy"
  source "haproxy-default"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[haproxy]"
end

template '/etc/haproxy/haproxy.cfg.ctmpl' do
  source 'haproxy.cfg.ctmpl.erb'
  action :create
  notifies :restart, "service[haproxy]"
end

include_recipe "consul::default"
include_recipe "consul-services::haproxy"

node.normal['consul_template'] = {
  consul: '127.0.0.1:8500'
}

include_recipe "consul-template::default"

consul_template_config 'haproxy' do
  templates [{
    source: '/etc/haproxy/haproxy.cfg.ctmpl',
    destination: '/etc/haproxy/haproxy.cfg',
    command: 'service haproxy restart'
  }]
end
