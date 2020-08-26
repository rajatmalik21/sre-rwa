variable "activate_apis" {
  type = list(string)

  default = [
    "cloudresourcemanager",
    "compute",
    "iam",
    "servicenetworking",
    "sqladmin"
  ]
}

variable "billing_account" {
  type = string

  description = "GCP Billng Account ID to attach to the project created. Eg: 0123Z8-239V9-2232D5"
}

variable "cloudsql" {
  type = object({
    database_version = string
    db_name          = string
    name             = string
    tier             = string
    username         = string
    zone             = string
  })

  default = {
    database_version = "MYSQL_5_7"
    db_name          = "wordpress"
    name             = "cloudsql-mysql"
    tier             = "db-n1-standard-1"
    username         = "wordpress"
    zone             = "us-east4-a"
  }
}

variable "folders" {
  type = list(string)

  default     = ["folder"]
  description = "List of folders to be created"
}

variable "gce" {
  type = object({
    destination_paths      = list(string)
    images                 = list(string)
    machine_types          = list(string)
    names                  = list(string)
    service_account_scopes = list(list(string))
    source_files           = list(string)
    tags                   = list(list(string))
    zone                   = string
  })

  default = {
    destination_paths = ["/var/tmp/wp_vhost.conf", "/var/tmp/redis.conf"]
    images            = ["debian-cloud/debian-10", "debian-cloud/debian-10"]
    machine_types     = ["n1-standard-1", "n1-standard-2"]
    names             = ["wordpress", "redis"]
    service_account_scopes = [
      ["userinfo-email", "compute-ro", "storage-ro"],
      ["userinfo-email", "compute-ro", "storage-ro"]
    ]
    source_files = ["wordpress", "redis.conf"]
    tags = [
      ["wordpress"],
      ["redis"]
    ]
    # template_vars = [
    #   { }
    # ]
    zone = "us-east4-a"
  }
  description = "Object variable to hold GCE instances attributes. For the variables within type list, the position zero refers to wordpress and position one to redis"
}

variable "org_id" {
  type = string

  description = "GCP Organization ID. Eg: 012345678910"
}

variable "parent" {
  type = string

  description = "Folder or organization where the folder will be created. Valid formats are folders/123457809 or organizations/123455611"
}

variable "project_name" {
  type = string

  default     = "project-xyz"
  description = "Name for project that will be created"
}

variable "routes" {
  type = list(map(string))

  default = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
  description = "Routes to be created within VPC"
}

variable "skip_gcloud_download" {
  type = bool

  default     = false
  description = "Whether gcloud needs to be download or not. Set false if you have no gcloud installed or true if you already have it"
}

variable "subnet" {
  type = object({
    description           = string
    region                = string
    subnet_private_access = bool
    subnet_flow_logs      = bool
  })

  default = {
    description           = "This subnet has a description"
    region                = "us-east4"
    subnet_private_access = true
    subnet_flow_logs      = false
  }
  description = "Object to hold subnet's data"
}

