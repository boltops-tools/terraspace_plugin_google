lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for interface

require "terraspace_provider_gcp/version"
require "terraspace_provider_gcp/autoloader"
TerraspaceProviderGcp::Autoloader.setup

module TerraspaceProviderGcp
  class Error < StandardError; end
end

Terraspace::Provider.register("gcp",
  backend: "gcs",
  root: File.dirname(__dir__),
  resource_map: {google: "gcp"},
)
