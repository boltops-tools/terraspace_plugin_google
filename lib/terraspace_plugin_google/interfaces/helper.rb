module TerraspacePluginGoogle::Interfaces
  module Helper
    include Terraspace::Plugin::Helper::Interface

    def google_secret(name, options={})
      Secret.new(@mod, options).fetch(name)
    end
    cache_helper :google_secret
  end
end
