lib = File.expand_path("../../../", __FILE__)
$:.unshift(lib)

require "memoist"
require "terraspace" # for interface

require "terraspace_provider_google/version"
require "terraspace_provider_google/autoloader"
TerraspaceProviderGoogle::Autoloader.setup

module TerraspaceProviderGoogle
  class Error < StandardError; end

  # Friendlier method for config/providers/google.rb. Example:
  #
  #     TerraspaceProviderGoogle.configure do |config|
  #       config.gcs.versioning = true
  #     end
  #
  def configure(&block)
    Interfaces::Config.instance.configure(&block)
  end
  extend self
end

Terraspace::Provider.register("google",
  backend: "gcs",
  config_instance: TerraspaceProviderGoogle::Interfaces::Config.instance,
  layer_class: TerraspaceProviderGoogle::Interfaces::Layer,
  root: File.dirname(__dir__),
)
