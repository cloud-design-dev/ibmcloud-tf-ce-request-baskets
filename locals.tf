locals {
  prefix = random_string.prefix.result

  tags = [
    "owner:${var.project_owner}",
    "provider:ibm",
    "region:${var.ibmcloud_region}"
  ]

  database_id       = var.existing_postgres_instance != "" ? data.ibm_database.database[0].id : ibm_database.postgresql_db[0].id
  database_host     = ibm_resource_key.postgres_connection.credentials["connection.postgres.hosts.0.hostname"]
  database_port     = ibm_resource_key.postgres_connection.credentials["connection.postgres.hosts.0.port"]
  database_password = ibm_resource_key.postgres_connection.credentials["connection.postgres.authentication.password"]
  database_user     = ibm_resource_key.postgres_connection.credentials["connection.postgres.authentication.username"]
}
