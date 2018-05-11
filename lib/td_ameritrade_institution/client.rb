require "td_ameritrade_institution/requests/account_numbers/create"
require "td_ameritrade_institution/requests/accounts/create"

module TDAmeritradeInstitution
  class Client

    attr_reader :access_token

    def initialize(access_token:)
      @access_token = access_token
    end

    def account_number(params)
      Requests::AccountNumbers::Create.new(access_token: access_token, **params).call
    end

    def create_account(params)
      Requests::Accounts::Create.new(access_token: access_token, **params).call
    end
  end
end
