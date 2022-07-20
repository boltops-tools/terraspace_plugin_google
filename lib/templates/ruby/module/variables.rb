variable("name",
  description: "bucket name (required)",
  type:        "string",
)

variable("uniform_bucket_level_access",
  description: "uniform_bucket_level_access",
  type:        "bool",
  default:     false,
)

variable("location",
  description: "location",
  type:         "string",
  default:      "US",
)
