data "ibm_database" "database" {
  count             = var.existing_database != "" ? 1 : 0
  name              = var.existing_database
  location          = var.region
  resource_group_id = module.resource_group.resource_group_id
}

