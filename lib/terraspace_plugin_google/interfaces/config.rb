module TerraspacePluginGoogle::Interfaces
  class Config
    include Terraspace::Plugin::Config::Interface
    include Singleton

    # interface method
    # load_project_config: config/plugins/google.rb
    def provider
      "google"
    end

    # interface method
    def defaults
      c = ActiveSupport::OrderedOptions.new
      c.auto_create = true
      c.gcs = ActiveSupport::OrderedOptions.new
      c.gcs.versioning = true
      c
    end
  end
end
