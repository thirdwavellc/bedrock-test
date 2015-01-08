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
    value = "http://bedrock.stg"
  }

  key {
    name = "wp_siteurl"
    path = "bedrock/wp_siteurl"
    value = "http://bedrock.stg/wp"
  }

  key {
    name = "auth_key"
    path = "bedrock/auth_key"
    value = "J[!%fM.n6b<P~Mcnui;PU6XveFr<<#@wWH/1-+^M=3>_b+;v|+@UXu^20,PN6m!o"
  }

  key {
    name = "secure_auth_key"
    path = "bedrock/secure_auth_key"
    value = "U7&AZR$Rg1zhSuDSlb?9w%x 7$wz}=OG0q7l7G2%,>_Mil+um~`I3orx<NX$G/g="
  }

  key {
    name = "logged_in_key"
    path = "bedrock/logged_in_key"
    value = "n$d_f6V|UCM3OD]0t%; >mg&Z3P+0V]%u>VAUcAbF$5)dPGwqCffOl_a^w=B(&c|"
  }

  key {
    name = "nonce_key"
    path = "bedrock/nonce_key"
    value = "4XAl00n+A(@DueZLG4Q-&x_RU$)zP_ygEYs`lG LlT%FYA*`+t@7RSl/r`w7@V%c"
  }

  key {
    name = "auth_salt"
    path = "bedrock/auth_salt"
    value = "f,,rz^3KvE&)4T9V#Gpp{AndqK!>+L`/E[o4Z*a-h&Z#wut;1JlM9yQ}8m%0Y5X~"
  }

  key {
    name = "secure_auth_salt"
    path = "bedrock/secure_auth_salt"
    value = "P#TaQT-YwFwS0QNo{Y1U[dHSqhe%$23oAio&2.A]AWD<|*b]C3Fl6#3[-8YTwo8W"
  }

  key {
    name = "logged_in_salt"
    path = "bedrock/logged_in_salt"
    value = "w z{*Z!ei|+h*,=fWxqp;-|&OXw!@`t.$S)ReQVnQNvtHny`KPfGvei!2FHzv0t."
  }

  key {
    name = "nonce_salt"
    path = "bedrock/nonce_salt"
    value = "f|MkP,x+HSk%5J4c{!Ih^R*D k2d@ ?*_L<wEko#2zMu8cwT#40NhE&`PF.mn,~."
  }
}

resource "consul_keys" "haproxy" {
  key {
    name = "maxconn"
    path = "haproxy/global/maxconn"
    value = "4096"
  }

  key {
    name = "host"
    path = "haproxy/admin/host"
    value = "0.0.0.0"
  }

  key {
    name = "port"
    path = "haproxy/admin/port"
    value = "22002"
  }
}
