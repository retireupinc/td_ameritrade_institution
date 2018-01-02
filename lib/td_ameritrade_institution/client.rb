module TDAmeritradeInstitution
  class Client
    include Authentication

    attr_reader :config

    def initialize(options = {})
      @config = TDAmeritradeInstitution.config
      raise TDAmeritradeInstitution::ConfigurationError.new "Configuration required." if @config.nil?
      @options = options
    end

    def account_number(params)
      request_body = Requests::AccountNumber.build(params)
      # What kind of request TD?
      HTTParty.get(build_path('prospective-accounts/account-id.xml'), {
        headers: build_request_header,
        body: request_body
      })
    end

    private

    def build_path(resource)
      "#{config.api_url}#{resource}"
    end

    def build_request_header
      {
        'Authorization' => "Bearer #{@options[:oauth_token]}"
      }
    end
  end
end
