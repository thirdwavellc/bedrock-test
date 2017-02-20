set :stage, :staging
set :deploy_to, '/var/www/bedrock-test'

server '172.20.10.11', user: 'deploy', roles: %w{web app}
server '172.20.10.12', user: 'deploy', roles: %w{web app}

fetch(:default_env).merge!(wp_env: :staging)
