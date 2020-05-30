require "gcp_data"

module TerraspaceProviderGoogle::Interfaces
  class Region
    extend Memoist

    # interface method
    def current
      gcp_data.region
    end

    # interface method
    def provider
      "google"
    end

    def gcp_data
      GcpData
    end
  end
end
