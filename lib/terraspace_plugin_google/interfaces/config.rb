module TerraspacePluginGoogle::Interfaces
  class Config
    include Terraspace::Plugin::Config::Interface
    include Singleton

    def provider
      "google"
    end

    def defaults
      c = ActiveSupport::OrderedOptions.new
      c.gcs = ActiveSupport::OrderedOptions.new
      c.gcs.versioning = true
      c
    end
  end
end
