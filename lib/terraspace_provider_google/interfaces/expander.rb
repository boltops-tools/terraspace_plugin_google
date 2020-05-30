require "gcp_data"

module TerraspaceProviderGoogle::Interfaces
  class Expander
    include Terraspace::Provider::Expander::Interface
    delegate :project, :region, to: :gcp_data

    def gcp_data
      GcpData
    end
  end
end
