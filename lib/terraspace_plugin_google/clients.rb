require "google-cloud-resource_manager"
require "google-cloud-secret_manager"
require "google/cloud/storage"

module TerraspacePluginGoogle
  module Clients
    extend Memoist

    def initialize(*)
      # So google sdk newer versions use GOOGLE_CLOUD_PROJECT instead of GOOGLE_PROJECT
      # Found out between google-cloud-storage-1.35.0 and google-cloud-storage-1.28.0
      # Though it seems like an library underneath that with the change.
      # Keeping backwards compatibility to not create breakage users who already have GOOGLE_PROJECT
      # But then setting GOOGLE_CLOUD_PROJECT so it works with the SDK.
      # For users, who set GOOGLE_CLOUD_PROJECT that will work also.
      ENV['GOOGLE_CLOUD_PROJECT'] ||= ENV['GOOGLE_PROJECT']
      super
    end

    def secret_manager_service
      Google::Cloud::SecretManager.secret_manager_service
    end
    memoize :secret_manager_service

    def storage
      Google::Cloud::Storage.new
    end
    memoize :storage

    def resource_manager
      Google::Cloud.new.resource_manager
    end
    memoize :resource_manager
  end
end
