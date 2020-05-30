resource "random_pet" "bucket" {
  length = 2
}

module "bucket" {
  source = "../../modules/example"

  name               = "bucket-${random_pet.bucket.id}"
  bucket_policy_only = var.bucket_policy_only
}
