module TDAmeritradeInstitution
  class Authentication
    include Requester
    attr_reader :config, :client_id, :client_secret

    class << self
      def get_token(**params)
        new.get_token(**params)
      end

      def refresh_token!(**params)
        new.refresh_token!(**params)
      end
    end

    def initialize(config: TDAmeritradeInstitution.config, client_id: config.client_id, client_secret: config.client_secret)
      @config = config
      @client_id = client_id
      @client_secret = client_secret
    end

    def get_token(veo_user:, veo_pass:, grant_type:, access_type: nil)
      body = {
        grant_type: grant_type,
        username: "#{veo_user}@VEO.ADVISOR",
        password: veo_pass,
        access_type: access_type,
      }
      response = post(
        url: config.token_url,
        body: body,
        headers: build_auth_headers
      )
      build_token(response.body)
    end

    def refresh_token!(refresh_token:, access_type: nil)
      response = post(
        url: config.token_url,
        body: {
          grant_type: 'refresh_token',
          refresh_token: refresh_token,
          access_type: access_type
        },
        headers: build_auth_headers
      )
      build_token(response.body)
    end

    private

    def build_token(response_body)
      OpenStruct.new(JSON.parse(response_body))
    end

    def build_auth_headers
      encoded_auth = Base64.strict_encode64("#{client_id}:#{client_secret}")
      {
        'Authorization' => "Basic #{encoded_auth}"
      }
    end
  end
end
