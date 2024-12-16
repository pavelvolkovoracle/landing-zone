locals {
  test_compartment_ocid = var.compartment_ocid != "" ? var.compartment_ocid : var.tenancy_ocid
}

module "home_compartment" {
  source = "./modules/compartment"
  count = var.create_test_compartment ? 1 : 0 
  compartment_parent_id     = local.test_compartment_ocid
  compartment_name          = "${var.test_name}_compartment"
  compartment_description   = "Test Compartment"
  compartment_replication_delay = "${var.compartment_replication_delay}s"
  enable_compartment_delete = true

  providers = {
    oci = oci.home_region
  }
} 

resource "time_sleep" "testing_delay" {
  create_duration = "${var.compartment_replication_delay}s"
}

resource "oci_objectstorage_bucket" "test_bucket" {
  compartment_id = local.test_compartment_ocid
  name           = "${var.test_name}_bucket"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  storage_tier   = var.bucket_type
  depends_on      = [time_sleep.testing_delay]
}

resource "oci_objectstorage_bucket" "newversion_bucket" {
  compartment_id = local.test_compartment_ocid
  name           = "${var.test_name}_new_bucket"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  storage_tier   = var.bucket_type
}

resource "oci_objectstorage_bucket" "additional_bucket" {
  for_each       = toset(var.additional_buckets)
  compartment_id = local.test_compartment_ocid
  name           = "${var.test_name}_bucket_${each.key}"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  storage_tier   = var.bucket_type
}

