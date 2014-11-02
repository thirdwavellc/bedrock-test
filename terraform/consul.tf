provider "consul" {
  address = "172.20.20.10:8500"
  datacenter = "vagrant"
}

resource "consul_keys" "bedrock" {
  key {
    name = "db_name"
    path = "bedrock/db_name"
    value = "bedrock_production"
  }

  key {
    name = "db_user"
    path = "bedrock/db_user"
    value = "bedrock"
  }

  key {
    name = "db_password"
    path = "bedrock/db_password"
    value = "bedrock"
  }

  key {
    name = "db_host"
    path = "bedrock/db_host"
    value = "192.168.33.20"
  }

  key {
    name = "wp_env"
    path = "bedrock/wp_env"
    value = "production"
  }

  key {
    name = "wp_home"
    path = "bedrock/wp_home"
    value = "http://bedrock.dev"
  }

  key {
    name = "wp_siteurl"
    path = "bedrock/wp_siteurl"
    value = "http://bedrock.dev/wp"
  }
}
