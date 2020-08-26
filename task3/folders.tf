module "folders" {
  source  = "terraform-google-modules/folders/google"
  version = "~> 2.0"

  names     = var.folders
  parent    = var.parent
  set_roles = true
}
