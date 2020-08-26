locals {
  egress_tag = var.routes[0].tags
  /*
    Random instance name needed because:
    "You cannot reuse an instance name for up to a week after you have deleted an instance."
    See https://cloud.google.com/sql/docs/mysql/delete-instance for details.
  */
  cloudsql_region_list = [local.cloudsql_zone_split[0], local.cloudsql_zone_split[1]]
  cloudsql_region      = join("-", local.cloudsql_region_list)
  cloudsql_zone_split  = split("-", var.cloudsql.zone)
  cloudsql_zone        = local.cloudsql_zone_split[2]
  gce_region_list      = [local.gce_zone_split[0], local.gce_zone_split[1]]
  gce_region           = join("-", local.gce_region_list)
  gce_zone_split       = split("-", var.gce.zone)
}
