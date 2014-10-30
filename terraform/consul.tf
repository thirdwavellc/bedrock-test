provider "consul" {
  address = "172.20.20.10:8500"
  datacenter = "vagrant"
}

resource "consul_keys" "bedrock1" {
  key {
    name = "db_name"
    path = "bedrock1/db_name"
    value = "bedrock1_production"
  }

  key {
    name = "db_user"
    path = "bedrock1/db_user"
    value = "bedrock1"
  }

  key {
    name = "db_password"
    path = "bedrock1/db_password"
    value = "bedrock1"
  }

  key {
    name = "db_host"
    path = "bedrock1/db_host"
    value = "localhost"
  }

  key {
    name = "wp_env"
    path = "bedrock1/wp_env"
    value = "production"
  }

  key {
    name = "wp_home"
    path = "bedrock1/wp_home"
    value = "http://bedrock.dev"
  }

  key {
    name = "wp_siteurl"
    path = "bedrock1/wp_siteurl"
    value = "http://bedrock.dev/wp"
  }
}
