module TerraspaceProviderGoogle::Interfaces
  class Backend
    include Terraspace::Provider::Backend::Interface
    include TerraspaceProviderGoogle::Clients

    def call
      bucket = @info["bucket"]
      unless bucket # not bucket provided
        puts "ERROR: no bucket value provided in your terraform backend config".color(:red)
        exit 1
      end
      if exist?(bucket)
        # puts "Bucket already exist: #{bucket}"
      else
        puts "Creating bucket: #{bucket}"
        create_bucket(bucket)
      end
    end

    def create_bucket(bucket)
      c = TerraspaceProviderGoogle::Interfaces::Config.instance.config.gcs
      storage.create_bucket(bucket) do |b|
        b.versioning = c.versioning
      end
    end

    def exist?(name)
      !!storage.bucket(name)
    rescue Google::Cloud::PermissionDeniedError => e
      puts "#{e.class}: #{e.message}"
      puts "ERROR: Bucket is not available: #{name}".color(:red)
      puts "Bucket might be owned by someone else or is on another one of your Google accounts."
      exit 1
    end
  end
end
