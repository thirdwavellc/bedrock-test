# Bedrock Test

This repo serves as a reference implementation for deploying highly available
WordPress applications using Bedrock, Chef, and Consul, among other tools.

**Warning:** Depending on the environment you're running, this could require a
lot of resources. You will be running up to 8+ virtual machines locally, so make sure
you're running this on a relatively beefy machine. We would recommend at least
16GB of RAM for optimal performance, however it has worked on machines with as
little as 8GB of RAM.

## Installation/Usage

### Consul

We are using consul for monitoring, as well as template generation using
[consul-template](https://github.com/hashicorp/consul-template).

#### Consul Server Cluster

The staging environment requires a cluster of consul servers. We have setup a
simple vagrant configuration that will handle this for you, which you can find
on github:
[vagrant-consul-cluster](https://github.com/adamkrone/vagrant-consul-cluster).

Simply clone the repo, cd into its directory, and run:

	vagrant up

This will create a 3-node cluster of consul servers.

#### Terraform

There are a few keys that we need to add to consul in order to properly
generate the templates for the web servers and haproxy. You can either do this
through the web ui, or using [Terraform](https://terraform.io/).

From the terraform directory, run:

	terraform apply

to automatically add the keys to your consul cluster.

### Virtual Machines

There are two sets of virtual machines: development and staging.

#### Development

To test the development environment, copy the '.env.example' file to a new file
'.env', and run:

	vagrant up dev

When this completes, it should be accessible at
[bedrock.dev](http://bedrock.dev)

#### Staging

As mentioned, the staging environment requires the consul cluster to be
running. Before you start any virtual machines, you will need to modify the
cookbooks/chef-bedrock/recipes/web.rb recipe:

	ssh_import_ids ['adamkrone'] # change 'adamkrone' to your Github username

This will automatically import your public keys stored on Github to the machine
you are provisioning. Make sure your local computer's public key is registered
with your Github account. Password-based ssh login for the deploy user is not
enabled, so Capistrano will fail to deploy unless you have an ssh key imported.
If you are unsure how to add your ssh key to Github, or how to create one in
the first place, please refer to
[Github's documentation](https://help.github.com/articles/generating-ssh-keys/)

To start the staging environment:

	vagrant up staging-web staging-db

##### Deployment

For the staging environment we use Capistrano for deployment, so make sure you
have ruby installed, and install the dependencies:

	bundle install

A staging Capistrano stage has been added for deployment using Capistrano:

	bundle exec cap staging deploy

When this completes, it should be accessible at
[bedrock.stg](http://bedrock.stg)
