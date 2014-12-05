# Bedrock Test

This repo serves as a reference implementation for deploying highly available
WordPress applications using Bedrock, Chef, and Consul, among other tools.

Previously, this cookbook accommodated multiple configurations (all-in-one,
multi-tenant, consul, haproxy, etc.), however we are now standardizing on a
single configuration designed for high availability. This ultimately merges the
consul and haproxy aspects, and will also allow for multi-tenancy. It will not,
however, include any reference for an all-in-one implementation, as this does
not match our end goal. It should still be possible to do an all-in-one config
by simply using all recipes on a single node, excluding any unneeded elements
(e.g. haproxy, lsyncd/csync2, etc.), however it remains untested.

**Warning:** This requires a lot of resources. You will be running 8+ virtual
machines locally, so make sure you're running this on a relatively beefy machine.
We would recommend at least 16GB of RAM for optimal performance, however it has
worked on machines with as little as 8GB of RAM.

## Installation/Usage

### Consul

We are using consul for monitoring, as well as template generation using
[consul-template](https://github.com/hashicorp/consul-template).

#### Consul Server Cluster

Before you start up the bedrock-test cluster, you will need a cluster of consul
servers. We have setup a simple vagrant configuration that will handle this for
you, which you can find on github:
[vagrant-consul-cluster](https://github.com/adamkrone/vagrant-consul-cluster).

#### Terraform

There are a few keys that we need to add to consul in order to properly generate
the templates for the web servers and haproxy. You can either do this through
the web ui, or using [Terraform](https://terraform.io/).

From the terraform directory, run:

	terraform apply

to automatically add the keys to your consul cluster.

### Virtual Machines

Once you have the consul server cluster running, you can move on to the bedrock
test cluster. Before you start any virtual machines, enter your Github account
name in the GITHUB_ACCOUNTS constant, located in the Vagrantfile:

	GITHUB_ACCOUNTS = ['your-name-here']

This will automatically import your public keys stored on Github to the machine
you are provisioning. Make sure your local computer's public key is registered
with your Github account. Password-based ssh login for the deploy user is not
enabled, so Capistrano will fail to deploy unless you have an ssh key imported.
If you are unsure how to add your ssh key to Github, or how to create one in
the first place, please refer to
[Github's documentation](https://help.github.com/articles/generating-ssh-keys/)

To start up the cluster:

	vagrant up

### Deploy

Bedrock uses Capistrano to deploy, so make sure you have ruby installed and
install the gems.

	bundle install

A production stage has been added for deployment using Capistrano:

	bundle exec cap production deploy

When this completes, it should be accessible at [bedrock.dev](http://bedrock.dev)
