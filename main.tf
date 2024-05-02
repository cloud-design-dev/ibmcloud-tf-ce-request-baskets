


module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.5"
  existing_resource_group_name = var.existing_resource_group
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}

resource "random_string" "admin_password" {
  length  = 32
  special = false
}

resource "random_string" "rb_master_token" {
  length  = 32
  special = false
}

resource "ibm_database" "postgresql_db" {
  count             = var.existing_database == "" ? 1 : 0
  resource_group_id = module.resource_group.resource_group_id
  name              = "${local.prefix}-postgres"
  service           = "databases-for-postgresql"
  plan              = "standard"
  location          = var.region
  adminpassword     = random_string.admin_password.result

  group {
    group_id = "member"
    memory {
      allocation_mb = 1024
    }
    disk {
      allocation_mb = 5120
    }
  }
  tags = local.tags
}

resource "ibm_resource_key" "postgres_connection" {
  name                 = "${local.prefix}-credentials"
  resource_instance_id = local.database_id
}

resource "ibm_code_engine_project" "code_engine_project_instance" {
  name              = "${local.prefix}-ce-project"
  resource_group_id = module.resource_group.resource_group_id
}

resource "ibm_code_engine_config_map" "app_configmap" {
  project_id = ibm_code_engine_project.code_engine_project_instance.id
  name       = "${local.prefix}-app-configmap"

  data = {
    PORT   = "8080"
    DB     = "sql"
    BASKET = "ball"
  }
}

resource "ibm_code_engine_secret" "db_credentials" {
  project_id = ibm_code_engine_project.code_engine_project_instance.id
  name       = "${local.prefix}-database-connection"
  format     = "generic"

  data = {
    CONN = "postgres://${local.database_user}:${local.database_password}@${local.database_host}:${local.database_port}/ibmclouddb?sslmode=require"
  }
}

resource "ibm_code_engine_app" "request_baskets" {
  project_id          = ibm_code_engine_project.code_engine_project_instance.project_id
  name                = "${local.prefix}-rb-app"
  image_reference     = "darklynx/request-baskets"
  scale_min_instances = 1
  scale_max_instances = 1


  run_env_variables {
    type      = "secret_full_reference"
    reference = "${local.prefix}-database-connection"
  }

  run_env_variables {
    type      = "config_map_full_reference"
    reference = "${local.prefix}-app-configmap"
  }

}