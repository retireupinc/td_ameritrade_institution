module TDAmeritradeInstitution
  module Requests
    module AccountNumbers
      class Create < Base
        attr_reader :rep_code, :account_segment, :description, :access_token
        xml_template("lib/td_ameritrade_institution/request_templates/account_numbers/create.xml.erb")

        def initialize(access_token:, rep_code:, account_segment:, description:)
          @access_token = access_token
          @rep_code = rep_code
          @account_segment = account_segment
          @description = description
        end

        def call
          xml_response_wrap { response }
        end

        private

        def response
          @response ||= post(
            url: "#{config.api_url}inst-account-edgeapi-v1/prospective-accounts/account-id.xml",
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
