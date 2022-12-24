variable "name" {
  default = "postgres"
}

provider "postgresql" {
  alias = "pg1"
  # host            = "${var.name}" // will not work because 'postgres' is only resolved within the docker dns
  host            = "localhost"
  port            = 5432
  username        = "postgres"
  password        = ""
  sslmode         = "disable"
  connect_timeout = 15
}

resource "postgresql_database" "dev_db" {
  provider = "postgresql.pg1"
  name     = "dev_db"
}