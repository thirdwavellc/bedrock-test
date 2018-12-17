set :deploy_to, '/var/www/bedrock-test'

server 'php01.sndbx.aura.thirdwave.local', user: 'deploy', roles: %w{web app}
server 'php02.sndbx.aura.thirdwave.local', user: 'deploy', roles: %w{web app}
