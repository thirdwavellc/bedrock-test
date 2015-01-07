ip_address = node['network']['interfaces']['eth1']['addresses'].detect{|k,v| v['family'] == 'inet' }.first

node.default['consul']['service_mode'] = 'client'
node.default['consul']['service_user'] = 'root'
node.default['consul']['service_group'] = 'root'
node.default['consul']['servers'] = ['172.20.20.10', '172.20.20.11', '172.20.20.12']
node.default['consul']['bind_interface'] = 'eth1'
node.default['consul']['bind_attr'] = ip_address
node.default['consul']['datacenter'] = 'vagrant'
