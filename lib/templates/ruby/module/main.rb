resource("google_storage_bucket", "this",
  name:              var.name,
  bucket_policy_only:var.bucket_policy_only,
)
