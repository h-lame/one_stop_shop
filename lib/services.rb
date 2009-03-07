require 'yaml'

class Services
  class << self

    def init
      @services ||= YAML::load(File.open('./services.yaml'))
    end
  
    def services
      init
      @services
    end
  
    def service_url(service_name, post_code)
      init
      @services[service_name]['where'].gsub(':post_code', post_code)
    end
  
    def local_services
      init
      @services.select {|_, service_obj| service_obj['internal']}
    end
  end
end
