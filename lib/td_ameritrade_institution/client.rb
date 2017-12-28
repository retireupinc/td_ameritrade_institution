module TDAmeritradeInstitution
  class Client
    include HTTParty

    attr_reader :config

    def initialize
      @config = TDAmeritradeInstitution.config
    end

    def account_number(params)
      request_params = Requests::AccountNumber.build(params)
      # What kind of request TD?
      get(build_path('InstitutionalAPIv2/api/prospective-accounts/account-id.xml'), request_params)
    end

    private

    def build_path(resource)
      "#{config.api_url}#{resource}"
    end
  end
end
