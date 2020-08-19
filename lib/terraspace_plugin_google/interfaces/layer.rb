require "gcp_data"

module TerraspacePluginGoogle::Interfaces
  class Layer
    include Terraspace::Plugin::Layer::Interface
    extend Memoist

    # interface method
    def namespace
      GcpData.project
    end

    # interface method
    def region
      GcpData.region
    end
  end
end
