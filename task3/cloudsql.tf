resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "vpc-peering"
  purpose       = "VPC_PEERING"
  project       = module.project.project_id
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  depends_on = [google_service_networking_connection.private_vpc_connection]
  provider   = google-beta

  name    = "${var.cloudsql.name}-${random_id.db_name_suffix.hex}"
  region  = local.cloudsql_region
  project = module.project.project_id


  settings {
    tier = var.cloudsql.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.vpc.network_self_link
    }
  }
}

resource "google_sql_user" "users" {
  host     = "%"
  instance = google_sql_database_instance.instance.name
  name     = var.cloudsql.username
  password = random_id.db_user_pass.hex
  project  = module.project.project_id
}

resource "google_sql_database" "database" {
  instance = google_sql_database_instance.instance.name
  name     = var.cloudsql.db_name
  project  = module.project.project_id
}
