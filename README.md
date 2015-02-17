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
[vagrant-consul-cluster](https://github.com/thirdwavellc/vagrant-consul-cluster).

Simply clone the repo, cd into its directory, and run:

	vagrant up

This will create a 3-node cluster of consul servers.

We are currently using the ACL features of consul in order to match as closely
to production as possible. The master token is included in the README at the
vagrant-consul-cluster link above. When vagrant finishes creating/provisioning
the servers, access [the web ui](http://consul01:8500/ui/).

Click the settings cog in the upper right, and paste the master token in the
access token input box. You don't need to click any further buttons or refresh
the page (doing so will clear the access token and you will have to enter it
again). Instead, immediately click over to the ACL tab.

We are going to create an ACL token for the bedrock app. Click "New ACL", and
in the form on the right side of the page, enter "bedrock" for the name, set
the type to "client", and paste the following into the rules:

	key "" {
		policy = "deny"
	}

	key "bedrock/" {
		policy = "write"
	}

	key "haproxy/" {
		policy = "write"
	}

Upon creation, a token should be generated for the entry we just added. You
will need to copy this, and paste it into a few places, replacing the example
values currently in the repo.

terraform/consul.tf in one places:
  variable "consul_acl_token" {
    default = "3a6efcc8-b0e5-93e8-9188-b7cda829b929" # change me
  }

data_bags/consul/acl.json in one place:

	"token": "3a6efcc8-b0e5-93e8-9188-b7cda829b929" # change me

You can choose to not replace these values, as the default token is the master
token used for the ACL. This, however, isn't recommended as it differs from the
production environment.

The ACL should now be setup for our bedrock application.

#### Terraform

There are a few keys that we need to add to consul in order to properly
generate the templates for the web servers and haproxy. You can either do this
through the web ui, or using [Terraform](https://terraform.io/).

In either case, make sure you have properly setup the ACL as described in the
section above.

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

	github_accounts ['adamkrone'] # change 'adamkrone' to your Github username

This will automatically import your public keys stored on Github to the machine
you are provisioning. Make sure your local computer's public key is registered
with your Github account. Password-based ssh login for the deploy user is not
enabled, so Capistrano will fail to deploy unless you have an ssh key imported.
If you are unsure how to add your ssh key to Github, or how to create one in
the first place, please refer to
[Github's documentation](https://help.github.com/articles/generating-ssh-keys/)

To start the staging environment:

	vagrant up

This will also start the dev machine, but it's easier than typing in what is
necessary to start everything but the dev machine:

  vagrant up web0{1,2} db lb0{1,2}

##### Deployment

For the staging environment we use Capistrano for deployment, so make sure you
have ruby installed, and install the dependencies:

	bundle install

Two Capistrano stages have been added for deployment using Capistrano:

	bundle exec cap bedrock1 deploy
	bundle exec cap bedrock2 deploy

These correspond to the two apps we're deploying, in order to simulate a
multi-tenant environment. It's actually deploying the same app, but they each
have their own directory/db, so they should operate separately.

When this completes, it should be accessible at
[bedrock1.stg](http://bedrock1.stg) and
[bedrock2.stg](http://bedrock2.stg)
