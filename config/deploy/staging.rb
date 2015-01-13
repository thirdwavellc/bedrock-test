set :stage, :staging
set :deploy_to, '/var/www/bedrock'

server '192.168.33.11', user: 'deploy', roles: %w{web app}
server '192.168.33.12', user: 'deploy', roles: %w{web app}

fetch(:default_env).merge!(wp_env: :staging)
