require "base64"

module TerraspacePluginGoogle::Interfaces::Helper
  class Secret
    include TerraspacePluginGoogle::Clients
    include TerraspacePluginGoogle::Logging
    extend Memoist

    def initialize(mod, options={})
      @mod, @options = mod, options
      @base64 = options[:base64]
      @project_id = options[:google_project] || ENV['GOOGLE_CLOUD_PROJECT'] || ENV['GOOGLE_PROJECT'] || raise("GOOGLE_PROJECT env variable is not set. It's required.")
      # So google sdk newer versions use GOOGLE_CLOUD_PROJECT instead of GOOGLE_PROJECT
      # Found out between google-cloud-storage-1.35.0 and google-cloud-storage-1.28.0
      # Though it seems like an library underneath that with the change.
      # Keeping backwards compatibility to not create breakage users who already have GOOGLE_PROJECT
      # But then setting GOOGLE_CLOUD_PROJECT so it works with the SDK.
      # For users, who set GOOGLE_CLOUD_PROJECT that will work also.
      ENV['GOOGLE_CLOUD_PROJECT'] ||= @project_id
    end

    def fetch(short_name, version: "latest")
      value = fetch_value(short_name, version)
      value = Base64.strict_encode64(value).strip if @base64
      value
    end

    def fetch_value(short_name, version="latest")
      short_name = expansion(short_name) if expand?
      name = "projects/#{project_number}/secrets/#{short_name}/versions/#{version}"
      version = secret_manager_service.access_secret_version(name: name)
      version.payload.data
    rescue Google::Cloud::NotFoundError => e
      logger.info "WARN: secret #{name} not found".color(:yellow)
      logger.info e.message
      "NOT FOUND #{name}" # simple string so Kubernetes YAML is valid
    rescue Google::Cloud::InvalidArgumentError => e
      logger.info "WARN: secret #{name} not found".color(:yellow)
      logger.info e.message
      "NOT FOUND #{name}" # simple string so Kubernetes YAML is valid
    end

  private
    @@project_number = nil
    def project_number
      return @@project_number if @@project_number
      project = resource_manager.project(@project_id)
      @@project_number = project.project_number
    end

    delegate :expansion, to: :expander
    def expander
      TerraspacePluginGoogle::Interfaces::Expander.new(@mod)
    end
    memoize :expander

    def expand?
      !(@options[:expansion] == false || @options[:expand] == false)
    end
  end
end
