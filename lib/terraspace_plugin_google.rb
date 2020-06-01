require "memoist"
require "terraspace" # for interface

require "terraspace_plugin_google/version"
require "terraspace_plugin_google/autoloader"
TerraspacePluginGoogle::Autoloader.setup

module TerraspacePluginGoogle
  class Error < StandardError; end

  # Friendlier method for config/plugins/google.rb. Example:
  #
  #     TerraspacePluginGoogle.configure do |config|
  #       config.gcs.versioning = true
  #     end
  #
  def configure(&block)
    Interfaces::Config.instance.configure(&block)
  end
  extend self
end

Terraspace::Plugin.register("google",
  backend: "gcs",
  config_instance: TerraspacePluginGoogle::Interfaces::Config.instance,
  layer_class: TerraspacePluginGoogle::Interfaces::Layer,
  root: File.dirname(__dir__),
)
