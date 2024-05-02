# output "Postgresql" {
#   value = jsondecode(ibm_database.postgresql_db.configuration_schema)
# }

output "db" {
  value     = ibm_database.postgresql_db
  sensitive = true
}


output "app_url" {
  value = ibm_code_engine_app.request_baskets.endpoint
}