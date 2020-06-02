require "gcp_data"

module TerraspacePluginGoogle::Interfaces
  class Expander
    include Terraspace::Plugin::Expander::Interface
    delegate :project, :region, to: :gcp_data
    alias_method :namespace, :project
    alias_method :location, :region

    def gcp_data
      GcpData
    end
  end
end
