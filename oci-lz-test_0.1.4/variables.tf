variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "compartment_replication_delay" {
  type         = number
  description  =  "delay to allow compartments to replicate"
  default      = 90
}

variable "test_name" {
  type        = string
  description = "the name for test resources."
  #default = ""
}

variable "compartment_ocid" {
  type        = string
  description = "the ocid of the compartment test resources will live in. Defaults to tenancy root."
  default = ""
}

variable "create_test_compartment" {
  type   = bool
  description = "Create a test compartment"
  default = false
}

variable "additional_buckets" {
  type = list(string)
  description = "Names of additional buckets"
  default = []
}

variable "bucket_type" {
  type        = string
  description = "Storage Types for buckets."
  default     = "Standard"
}