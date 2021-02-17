set :deploy_to, '/var/www/bedrock-test'

server 'php01.qa.aura.chicago.thirdwave.3whst.com', user: 'deploy', roles: %w{web app}
server 'php02.qa.aura.chicago.thirdwave.3whst.com', user: 'deploy', roles: %w{web app}
