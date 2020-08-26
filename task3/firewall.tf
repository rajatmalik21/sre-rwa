resource "google_compute_firewall" "ssh-myip" {
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  name          = "allow-ssh-myip-all"
  network       = module.vpc.network_name
  project       = module.project.project_id
  source_ranges = [format("%s/32", data.external.myip.result.ip)]
}

resource "google_compute_firewall" "wordpress" {
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  name          = "allow-http-internet-wordpress"
  network       = module.vpc.network_name
  project       = module.project.project_id
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wordpress"]
}
