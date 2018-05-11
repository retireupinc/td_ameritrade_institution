module TDAmeritradeInstitution
  module Requester
    def post(url:, body:, headers:)
      _wrap_request(url) do |conn|
        conn.post do |req|
          req.headers = headers
          req.body = body
        end
      end
    end

    def get(url:, headers:)
      _wrap_request(url) do |conn|
        conn.get do |req|
          req.headers = headers
        end
      end
    end

    def _build_connection(url)
      Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def _wrap_request(url)
      conn = _build_connection(url)
      response = yield(conn)
      raise RequestError.new(response: response) unless response.success?
      response
    end
  end
end
