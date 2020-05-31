require "google/cloud/storage"

module TerraspacePluginGoogle
  module Clients
    extend Memoist

    def storage
      Google::Cloud::Storage.new
    end
    memoize :storage
  end
end
