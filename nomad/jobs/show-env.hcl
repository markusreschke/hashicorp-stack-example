job "show-env" {
  datacenters = ["dc1"]
  type = "batch"

  group "show-env" {
    count = 1

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "show-env" {
      driver = "raw_exec"

      vault {
        policies = ["service"]
      }

      template {
        data = <<EOH
          DBUSER="{{with secret "kv/service-credentials/database"}}{{.Data.user}}{{end}}"
          DBPASSWORD="{{with secret "kv/service-credentials/database"}}{{.Data.password}}{{end}}"
        EOH

        destination = "secrets/file.env"
        env         = true
      }

      config {
        command = "cmd.exe"
        args    = ["/c", "set"]
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}
