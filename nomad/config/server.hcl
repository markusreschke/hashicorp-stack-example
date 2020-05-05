data_dir  = "C:/dev/hashi/nomad/data"

bind_addr = "127.0.0.1"

# Für bind = Localhost muss advertising explizit konfiguriert werden
advertise {
  http = "127.0.0.1"
  rpc  = "127.0.0.1"
  serf = "127.0.0.1"
}

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled       = true
  network_interface = "WLAN"
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

plugin "docker" {
}

consul {
  address = "consul.service.consul:8500"
}

vault {
  enabled     = true
  address     = "http://vault.service.consul:8200"
  #address     = "http://127.0.0.1:8200"
  token       = "s.ZJdaBzGF2YgRgz8MpAZh5wEl"
  create_from_role = "nomad-cluster"
}
