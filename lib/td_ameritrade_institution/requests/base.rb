module TDAmeritradeInstitution
  module Requests
    class Base
      def self.build(params = {})
        new(params).build_request
      end
    end
  end
end
