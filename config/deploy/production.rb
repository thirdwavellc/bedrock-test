set :stage, :production

server '1.2.3.4', user: 'deploy', roles: %w{web app}

fetch(:default_env).merge!(wp_env: :production)

