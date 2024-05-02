variable "ibmcloud_api_key" {
  description = "The IBM Cloud API key to use for provisioning resources."
  type        = string
}

variable "region" {
  description = "The region where the Code Engine project will be created."
  type        = string
  default     = "us-south"
}

variable "owner" {
  description = "The owner of the resources. This will be set as a tag on supported resources."
  type        = string
}

variable "existing_resource_group" {
  description = "The name of an existing resource group to use for the resources."
  type        = string
}

variable "existing_database" {
  description = "The name of an existing database to use for the resources. If not provided, a new database will be created."
  type        = string
}