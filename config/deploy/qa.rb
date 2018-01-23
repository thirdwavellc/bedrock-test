set :deploy_to, '/var/www/bedrock-test'

server 'web01.qa.thirdwave.local', user: 'deploy', roles: %w{web app}
server 'web02.qa.thirdwave.local', user: 'deploy', roles: %w{web app}
