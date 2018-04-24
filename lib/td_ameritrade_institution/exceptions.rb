module TDAmeritradeInstitution
  class ConfigurationError < StandardError; end
  class RequestError < StandardError
    attr_reader :response

    def initialize(response:)
      @response = response
      super("#{response.status}: #{response.body}")
    end
  end
end
