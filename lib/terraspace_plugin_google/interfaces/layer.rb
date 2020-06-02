require "gcp_data"

module TerraspacePluginGoogle::Interfaces
  class Layer
    extend Memoist

    # interface method
    def namespace
      GcpData.project
    end

    # interface method
    def region
      GcpData.region
    end

    # interface method
    def provider
      "google"
    end
  end
end
