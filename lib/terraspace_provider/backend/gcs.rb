module TerraspaceProvider::Backend
  class Gcs
    include Terraspace::Provider::Backend::Interface
    include TerraspaceProvider::Clients

    def create
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
      x = storgae.get_bucket(name)
      puts "get_bucket result #{x}"
      true  # Bucket exist
    # rescue Aws::S3::Errors::NotFound
    #   false # Bucket does not exist
    # rescue Aws::S3::Errors::Forbidden => e
    #   puts "#{e.class}: #{e.message}"
    #   puts "ERROR: Bucket is not available: #{name}".color(:red)
    #   puts "Bucket might be owned by someone else or is on another one of your AWS accounts."
    #   exit 1
    end
  end
end
