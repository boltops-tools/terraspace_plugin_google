resource("random_pet","bucket",
  length: 2
)

module!("bucket",
  source: "../../modules/example",
  name:   "bucket-${random_pet.bucket.id}",
  uniform_bucket_level_access: var.uniform_bucket_level_access,
  location:                    var.location,
)
