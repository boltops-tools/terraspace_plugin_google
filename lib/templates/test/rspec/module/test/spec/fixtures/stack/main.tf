resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source = "../../modules/example"

  name               = "bucket-${random_pet.this.id}"
  bucket_policy_only = var.bucket_policy_only
}
