module TerraspaceProviderGcp::Interfaces
  class Backend
    include Terraspace::Provider::Backend::Interface
    include TerraspaceProviderGcp::Clients

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
        storage.create_bucket(bucket)
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
