variable "ibmcloud_api_key" {
  description = "The IBM Cloud API key to use for provisioning resources."
  type        = string
}

variable "ibmcloud_region" {
  description = "The region where the Code Engine project will be created."
  type        = string
  default     = "us-south"
}

variable "project_owner" {
  description = "The owner of the resources. This will be set as a tag on supported resources."
  type        = string
}

variable "existing_resource_group" {
  description = "The name of an existing resource group to use for the resources."
  type        = string
  default = ""
}

variable "existing_postgres_instance" {
  description = "The name of an existing Postgres database instance to use for the app. If not provided, a new database will be created."
  type        = string
  default = ""
}

