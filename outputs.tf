output "home_compartment_id" {
  value = var.create_test_compartment ? module.home_compartment[0].compartment_id : ""
}

output "bucket_name" {
  value = oci_objectstorage_bucket.test_bucket.name
}

output "bucket_namespace" {
  value = oci_objectstorage_bucket.test_bucket.namespace
}

output "new_bucket_name" {
  value = oci_objectstorage_bucket.newversion_bucket.name
}