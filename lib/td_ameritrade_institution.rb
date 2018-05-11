require "base64"
require "faraday"
require "nokogiri"

require "td_ameritrade_institution/version"
require "td_ameritrade_institution/exceptions"
require "td_ameritrade_institution/requester"
require "td_ameritrade_institution/requests/base"
require "td_ameritrade_institution/authentication"
require "td_ameritrade_institution/client"
require "td_ameritrade_institution/models"

module TDAmeritradeInstitution
  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield config
      if config.api_url
        config.api_url << '/' unless config.api_url[-1, 1] == '/'
      end
      config
    end

    def root_path
      name = "td_ameritrade_institution"
      spec = Bundler.load.specs.find{|s| s.name == name}
      return spec.full_gem_path if spec
      File.expand_path("..", __FILE__)
    end
  end

  class Configuration
    attr_accessor :api_url
    attr_accessor :token_url
    attr_accessor :client_id
    attr_accessor :client_secret

    def initialize(params = {})
      params.each do |k, v|
        self.send("#{k}=", v)
      end
    end
  end
end
