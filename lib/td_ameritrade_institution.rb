require "httparty"
require "nokogiri"

require "td_ameritrade_institution/version"
require "td_ameritrade_institution/requests/base"
require "td_ameritrade_institution/requests/account_number"
require "td_ameritrade_institution/client"

module TDAmeritradeInstitution
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
  end

  class Configuration
    attr_accessor :api_url
    attr_accessor :token_url
    attr_accessor :client_id
    attr_accessor :client_secret
  end
end
