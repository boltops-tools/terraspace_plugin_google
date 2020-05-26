lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for base classes

require "terraspace_provider_gcp/version"
require "terraspace_provider_gcp/autoloader"
TerraspaceProviderGcp::Autoloader.setup

module TerraspaceProviderGcp
  class Error < StandardError; end
end

Terraspace::Provider.register("gcs", "gcp")
