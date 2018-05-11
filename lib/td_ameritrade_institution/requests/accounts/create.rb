module TDAmeritradeInstitution
  module Requests
    module Accounts
      class Create < Base
        attr_reader :access_token, :access_token, :created_by, :address, :accounts
        xml_template("lib/td_ameritrade_institution/request_templates/accounts/create.xml.erb")

        def initialize(access_token:, created_by:, address:, accounts:)
          @access_token = access_token
          @created_by = created_by
          @address = address
          @accounts = accounts
        end

        def call
          xml_response_wrap { response }
        end

        def response
          @response ||= post(
            url: "#{config.api_url}inst-account-edgeapi-v1/prospective-accounts/account-application.xml",
            headers: headers,
            body: {
              inputXml: build_xml
            }
          )
        end

        def headers
          {
            'Authorization' => "Bearer #{access_token}",
          }
        end
      end
    end
  end
end
