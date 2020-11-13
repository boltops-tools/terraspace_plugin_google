require "google-cloud-secret_manager"
require "google/cloud/storage"

module TerraspacePluginGoogle
  module Clients
    extend Memoist

    def secret_manager_service
      Google::Cloud::SecretManager.secret_manager_service
    end
    memoize :secret_manager_service

    def storage
      Google::Cloud::Storage.new
    end
    memoize :storage
  end
end
