require 'yaml'

class ApiKeys
  class << self
    def init
      @keys ||= YAML::load(File.open('./api_keys.yaml'))
    end
  
    def key_for(service)
      init
      @keys[service]['key']
    end
  end
end
