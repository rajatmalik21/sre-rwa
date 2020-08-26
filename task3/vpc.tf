module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5"

  project_id   = module.project.project_id
  network_name = "vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.subnet.region
      subnet_private_access = var.subnet.subnet_private_access
      subnet_flow_logs      = var.subnet.subnet_flow_logs
      description           = var.subnet.description
    }
  ]

  secondary_ranges = {
    subnet-01 = []
  }

  routes = var.routes
}
