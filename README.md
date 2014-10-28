# Bedrock Test

This repo serves as a testing ground for deploying WordPress applications using
Bedrock. It uses Vagrant, Virtualbox, and Chef to configure the machines.

## Virtual Machines

Before you start any virtual machines, enter your Github account name in the
ssh-import-id section of the CHEF_JSON variable corresponding to the machine
you want to use, located in the Vagrantfile:

  ssh_import_id: {
    users: [{name: 'deploy', github_accounts: %w{your-name-here}}]
  }

This will automatically import your public keys stored on Github to the machine
you are provisioning. Make sure your local computer's public key is registered
with your Github account. Password-based ssh login for the deploy user is not
enabled, so Capistrano will fail unless you have an ssh key imported.

There are currently two types of machines configured:

### All-in-one Machine

This is a simple all-in-one machine. To start it:

  vagrant up production

### Multi-tenant Machine

This machine has two sites, bedrock1, and bedrock2. There are also two
cookbooks written to help configure them using the chef cookbook
[capistrano-wordpress](https://github.com/adamkrone/chef-capistrano-wordpress).
In this instance, we're deploying the same code as two different apps, but we
can create posts, upload media, etc. independently so we can test to make sure
they don't interfere with one another. To start the machine:

  vagrant up multi-tenant

## Deploy

Bedrock uses Capistrano to deploy, so make sure you have ruby installed and
install the gems.

  bundle install

Currently there are 3 stages setup:

* production
* bedrock1
* bedrock2

The production stage will deploy to the Production machine, while bedrock1 and bedrock2
will deploy to the Multi-tenant machine. To deploy bedrock1, for example:

  bundle exec cap bedrock1 deploy

When this completes, bedrock1 should be accessible at [bedrock1.dev](http://bedrock1.dev)

## Consul

There is a consul branch that currently implements joining a cluster, registering
apache and mysql as services with some basic checks, and writing bedrock1's .env
config file using [consul-template](https://github.com/hashicorp/consul-template).

Make sure you checkout the consul branch before continuing.

### Consul Server Cluster

To get a simple consul cluster to test out these features, refer to
[vagrant-consul-cluster](https://github.com/adamkrone/vagrant-consul-cluster).

### Terraform

The keys that consul-template uses to generate the .env config for bedrock1 must
be added after you spin up the consul server cluster. You can either do this
through the web ui, or using [Terraform](https://terraform.io/).

From the terraform directory, run:

  terraform apply

to automatically add the keys to your consul cluster.
