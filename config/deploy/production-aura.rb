set :deploy_to, '/var/www/bedrock-test'

server 'php01.prod.aura.newark.linode.3whst.com', user: 'deploy', roles: %w{web app}
server 'php02.prod.aura.newark.linode.3whst.com', user: 'deploy', roles: %w{web app}
