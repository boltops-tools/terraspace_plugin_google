require_relative 'lib/terraspace_plugin_google/version'

Gem::Specification.new do |spec|
  spec.name          = "terraspace_plugin_google"
  spec.version       = TerraspacePluginGoogle::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tung@boltops.com"]

  spec.summary       = "Terraspace Google Cloud Plugin"
  spec.homepage      = "https://github.com/boltops-tools/terraspace_plugin_google"
  spec.license       = "Apache2.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "gcp_data"
  spec.add_dependency "google-cloud-storage"
  spec.add_dependency "google-cloud-resource_manager"
  spec.add_dependency "google-cloud-secret_manager"
  spec.add_dependency "memoist"
  spec.add_dependency "zeitwerk"
end
