module TerraspacePluginGoogle::Interfaces
  module Helper
    def google_secret(name, options={})
      Secret.new(options).fetch(name)
    end
  end
end
