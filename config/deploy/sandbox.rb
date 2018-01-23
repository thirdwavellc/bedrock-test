set :deploy_to, '/var/www/bedrock-test'

server 'web01.sndbx.thirdwave.local', user: 'deploy', roles: %w{web app}
server 'web02.sndbx.thirdwave.local', user: 'deploy', roles: %w{web app}
