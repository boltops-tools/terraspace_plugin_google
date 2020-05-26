require "gcp_data"

module TerraspaceProvider::Expander
  class Gcs
    include Terraspace::Provider::Expander::Interface
    delegate :project, :region, to: :gcp_data

    def gcp_data
      $__gcp_data ||= GcpData
    end
  end
end
