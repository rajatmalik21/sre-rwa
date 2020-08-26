output "instances_external_ips" {
  value = {
    for instance in google_compute_instance.default :
    instance.name => instance.network_interface[0].access_config[0].nat_ip
  }
}

output "instances_internal_ips" {
  value = {
    for instance in google_compute_instance.default :
    instance.name => instance.network_interface[0].network_ip
  }
}

output "project_id" {
  value = module.vpc.project_id
}

output "cloudsql_ip" {
  value = google_sql_database_instance.instance.private_ip_address
}

output "cloudsql_user" {
  value = var.cloudsql.username
}

output "cloudsql_pass" {
  sensitive = true
  value     = random_id.db_user_pass.hex
}
