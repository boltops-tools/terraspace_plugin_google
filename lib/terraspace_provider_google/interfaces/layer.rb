require "gcp_data"

module TerraspaceProviderGoogle::Interfaces
  class Layer
    extend Memoist

    # interface method
    def region
      gcp_data.region
    end

    # interface method
    # not a typo, mapping project to "account" to confirm to interface
    def account
      gcp_data.project
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
