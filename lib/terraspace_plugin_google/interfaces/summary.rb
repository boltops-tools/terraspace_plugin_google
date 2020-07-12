module TerraspacePluginGoogle::Interfaces
  class Summary
    include Terraspace::Plugin::Summary::Interface
    include TerraspacePluginGoogle::Clients

    # 1. download state files to temp area
    # 2. show resources for each
    def call
      @bucket_name = @info['bucket']
      @prefix = @info['prefix']
      index = locate_env_index
      env_chars = Terraspace.env.size + 1
      @folder = @prefix[0..index+env_chars] # Example folder: us-central1/dev/
      @dest_base = "#{Terraspace.tmp_root}/statefiles/#{@bucket_name}"

      download_statefiles
      show_resources
    end

    def download_statefiles
      return if ENV['TS_SUMMARY_DOWNLOAD'] == '0'

      logger.info("Downloading statefiles to #{@dest_base}/#{@folder} ...")
      FileUtils.rm_rf(@dest_base)
      bucket = storage.bucket(@bucket_name)
      bucket.files(prefix: @folder).all do |f|
        file = bucket.file(f.name)
        # Note the f.name already includes the folder
        local_path = "#{@dest_base}/#{f.name}"
        FileUtils.mkdir_p(File.dirname(local_path))
        file.download(local_path)
      end
    end

    def show_resources
      Dir.glob("#{@dest_base}/#{@folder}**/default.tfstate").each do |path|
        show_each(path)
      end
    end

    def show_each(path)
      data = JSON.load(IO.read(path))
      resources = data['resources']
      return unless resources.size > 0

      pretty_path = path.sub(Regexp.new(".*#{@bucket_name}/#{@folder}"), '')
      logger.info "Resources for #{pretty_path.color(:green)}:"
      resources.each do |r|
        identifier = r['instances'].map do |i|
          i['attributes']['name'] || i['attributes']['id']
        end.join(',')
        logger.info "    #{r['type']}: #{identifier}"
      end
    end

    # Assume that the state files are within a env folder.
    # IE: us-central1/dev/stacks/vm
    # TODO: allow use to configure and override plugin behavior
    def locate_env_index
      regexp = Regexp.new("/#{Terraspace.env}/")
      index = @prefix.index(regexp)
      unless index
        logger.error "ERROR: Unable to find the #{Terraspace.env} position in the prefix"
        exit 1
      end
      index
    end

    def logger
      Terraspace.logger
    end
  end
end
