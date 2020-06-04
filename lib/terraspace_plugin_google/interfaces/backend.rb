module TerraspacePluginGoogle::Interfaces
  class Backend
    include Terraspace::Plugin::Backend::Interface
    include TerraspacePluginGoogle::Clients

    def call
      return unless TerraspacePluginGoogle.config.auto_create

      bucket = @info["bucket"]
      unless bucket # not bucket provided
        logger.error "ERROR: no bucket value provided in your terraform backend config"
        exit 1
      end
      if exist?(bucket)
        logger.debug "Bucket already exist: #{bucket}"
      else
        logger.info "Creating bucket: #{bucket}"
        create_bucket(bucket)
      end
    end

    def create_bucket(bucket)
      c = TerraspacePluginGoogle::Interfaces::Config.instance.config.gcs
      storage.create_bucket(bucket) do |b|
        b.versioning = c.versioning
      end
    end

    def exist?(name)
      !!storage.bucket(name)
    rescue Google::Cloud::PermissionDeniedError => e
      logger.error "#{e.class}: #{e.message}"
      logger.error "ERROR: Bucket is not available: #{name}".color(:red)
      logger.error "Bucket might be owned by someone else or is on another one of your Google accounts."
      exit 1
    end

    def logger
      Terraspace.logger
    end
  end
end
