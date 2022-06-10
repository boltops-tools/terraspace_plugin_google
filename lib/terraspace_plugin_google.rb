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

  def config
    Interfaces::Config.instance.config
  end

  @@logger = nil
  def logger
    @@logger ||= Terraspace.logger
  end

  def logger=(v)
    @@logger = v
  end

  extend self
end

Terraspace::Plugin.register("google",
  backend: "gcs",
  config_class: TerraspacePluginGoogle::Interfaces::Config,
  helper_class: TerraspacePluginGoogle::Interfaces::Helper,
  layer_class: TerraspacePluginGoogle::Interfaces::Layer,
  ci_class: TerraspacePluginGoogle::Interfaces::Ci,
  root: File.dirname(__dir__),
)
