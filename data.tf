data "ibm_database" "database" {
  count             = var.existing_postgres_instance != "" ? 1 : 0
  name              = var.existing_postgres_instance
  location          = var.ibmcloud_region
  resource_group_id = module.resource_group.resource_group_id
}

