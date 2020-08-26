resource "random_id" "db_user_pass" {
  byte_length = 12
}

resource "google_compute_instance" "default" {
  count = 2

  boot_disk {
    initialize_params {
      image = element(var.gce.images, count.index)
    }
  }
  machine_type = element(var.gce.machine_types, count.index)
  metadata_startup_script = templatefile(format("%s/templates/%s_install.sh.tpl", path.module, element(var.gce.names, count.index)), {
    db_host = google_sql_database_instance.instance.private_ip_address
    db_name = var.cloudsql.db_name
    db_user = var.cloudsql.username
    db_pass = random_id.db_user_pass.hex
  })
  name = element(var.gce.names, count.index)
  network_interface {
    access_config {

    }
    network    = module.vpc.network_name
    subnetwork = module.vpc.subnets_self_links[0]
  }
  project = module.project.project_id
  scratch_disk { # Local SSD disk
    interface = "SCSI"
  }
  service_account {
    scopes = element(var.gce.service_account_scopes, count.index)
  }
  tags = distinct(concat(list(local.egress_tag), element(var.gce.tags, count.index)))
  zone = var.gce.zone # deploy in the same zone to decrease the network latency between the cache and the webserver.
}
