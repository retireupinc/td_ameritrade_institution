module TDAmeritradeInstitution
  module Requests
    class Base
      def self.build(params = {})
        new(params).build_request
      end

      def build_headers
        {}
      end
    end
  end
end
