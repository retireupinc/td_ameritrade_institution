module TDAmeritradeInstitution
  module Authentication

    def authenticate!
      if password_auth?
        puts build_auth_headers
        response = HTTParty.post(config.token_url, {
          headers: build_auth_headers,
          body: {
            grant_type: 'password',
            username: "#{@options[:veo_user]}@VEO.ADVISOR",
            password: @options[:veo_pass],
            access_type: 'offline'
          }
        })
      elsif token_refresh?
        response = HTTParty.post(config.token_url, {
          headers: build_auth_headers,
          body: {
            grant_type: 'refresh',
            refresh_token: @options[:refresh_token]
          }
        })
      else
        raise ArgumentError.new "Missing credentials"
      end

      puts response
      yield @options[:veo_user], @options[:veo_pass] if block_given?
    end

    private

    def password_auth?
      @options[:veo_user] && @options[:veo_pass]
    end

    def token_refresh?
      @options[:oauth_token] && @options[:refresh_token]
    end

    def build_auth_headers
      {
        'Authorization' => "Basic #{config.client_id}:#{config.client_secret}"
      }
    end
  end
end
