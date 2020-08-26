module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 9.0"

  activate_apis        = formatlist("%s.googleapis.com", var.activate_apis)
  billing_account      = var.billing_account
  folder_id            = module.folders.id
  name                 = var.project_name
  org_id               = var.org_id
  random_project_id    = "true"
  skip_gcloud_download = var.skip_gcloud_download
}
