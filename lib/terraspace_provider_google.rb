lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for interface

require "terraspace_provider_google/version"
require "terraspace_provider_google/autoloader"
TerraspaceProviderGoogle::Autoloader.setup

module TerraspaceProviderGoogle
  class Error < StandardError; end
end

Terraspace::Provider.register("google",
  backend: "gcs",
  root: File.dirname(__dir__),
  region_class: TerraspaceProviderGoogle::Interfaces::Region, # used for layering
)
