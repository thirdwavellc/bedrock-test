#
# Cookbook Name:: bedrock
# Recipe:: haproxy
#
# Copyright (C) 2014
#
#
#

node.normal["haproxy"] = {
  "admin" => {
    "address_bind" => "192.168.33.10"
  },
  "members" => [{
    "hostname" => "bedrock01",
    "ipaddress" => "192.168.33.11",
    "port" => 80
  }, {
    "hostname" => "bedrock02",
    "ipaddress" => "192.168.33.12",
    "port" => 80
  }, {
    "hostname" => "bedrock03",
    "ipaddress" => "192.168.33.13",
    "port" => 80
  }]
}

include_recipe 'haproxy::default'
