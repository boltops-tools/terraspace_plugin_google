require "gcp_data"

module TerraspacePluginGoogle::Interfaces
  class Expander
    include Terraspace::Plugin::Expander::Interface
    delegate :project, :region, to: :gcp_data

    def gcp_data
      GcpData
    end
  end
end
