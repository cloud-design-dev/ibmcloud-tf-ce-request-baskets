output "db_connection_details" {
  value     = ibm_database.postgresql_db
  sensitive = true
}


output "app_url" {
  value = ibm_code_engine_app.request_baskets.endpoint
}

output "request_basket_master_token" {
  value = random_string.rb_master_token.result

}

