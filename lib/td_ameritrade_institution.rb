require "base64"
require "httparty"
require "nokogiri"

require "td_ameritrade_institution/version"
require "td_ameritrade_institution/exceptions"
require "td_ameritrade_institution/requests/base"
require "td_ameritrade_institution/requests/account_number"
require "td_ameritrade_institution/authentication"
require "td_ameritrade_institution/client"

module TDAmeritradeInstitution
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
    config.api_url << '/' unless config.api_url[-1, 1] == '/'
    config
  end

  class Configuration
    attr_accessor :api_url
    attr_accessor :token_url
    attr_accessor :client_id
    attr_accessor :client_secret

    def initialize
      # Actual endpoints would be helpful TD
      @token_url = 'https://api.tdameritrade.com/v1/oauth2/token'
      @api_url = 'http://XXXX:XXXX/InstitutionalAPIv2/api/'
    end
  end
end
