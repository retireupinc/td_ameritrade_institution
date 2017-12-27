require "httparty"
require "nokogiri"

require "td_ameritrade_institution/version"

module TDAmeritradeInstitution
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
  end

  class Configuration
    attr_accessor :oauth_token
    attr_accessor :refresh_token
    attr_accessor :api_url
    attr_accessor :token_url
    attr_accessor :client_id
    attr_accessor :client_secret
  end
end
