resource("google_storage_bucket", "this",
  name:                        var.name,
  uniform_bucket_level_access: var.uniform_bucket_level_access,
  location:                    var.location,
)
