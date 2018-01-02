module TDAmeritradeInstitution
  module Requests
    class AccountNumber < Base
      def initialize(rep_code:, account_segment:, description:)
        @rep_code = rep_code
        @account_segment = account_segment
        @description = description
      end

      def build_request
        {
          headers: build_headers,
          body: build_xml
        }
      end

      def build_xml
        builder = Nokogiri::XML::Builder.new do |xml|
          xml['api'].generateAccountNumberRequest('xmlns:api' => "urn:endpoints.api.inst.tda.com/AccountNumberGenerator") {
            xml['api'].repCode @rep_code
            xml['api'].accountSegment @account_segment
            xml['api'].description @description
          }
        end
        builder.to_xml
      end

    end
  end
end
