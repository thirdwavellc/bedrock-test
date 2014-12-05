set :stage, :production
set :deploy_to, '/var/www/bedrock'

server '192.168.33.11', user: 'deploy', roles: %w{web app}
server '192.168.33.12', user: 'deploy', roles: %w{web app}
server '192.168.33.13', user: 'deploy', roles: %w{web app}

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(~/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }

fetch(:default_env).merge!(wp_env: :production)

