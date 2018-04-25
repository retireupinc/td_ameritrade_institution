require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Authentication do
  let(:config) {
    TDAmeritradeInstitution::Configuration.new(
      api_url: "https://a-fake-td-api.com",
      token_url: "https://www.example.com/token",
      client_id: "a client_id",
      client_secret: "a client_secret"
    )
  }
  let(:response_headers) { {} }
  let(:response_status) { 200 }
  let(:response_body) {
    {
      access_token: "an access_token"
    }.to_json
  }
  subject { described_class.new(config: config) }

  before do
    stub_request(:post, "https://www.example.com/token").
      with(headers: {'Authorization' => /Basic .+/}, body: request_body).
      to_return(headers: response_headers, status: response_status, body: response_body)
  end

  describe "#get_token" do
    let(:grant_type) { "a grant_type" }
    let(:veo_user) { "a veo_user" }
    let(:veo_pass) { "a veo_pass" }
    let(:request_body) {
      {
        grant_type: grant_type,
        username: "#{veo_user}@VEO.ADVISOR",
        password: veo_pass,
        access_type: nil
      }
    }
    it "returns a token" do
      expect(subject.get_token(veo_pass: veo_pass, veo_user: veo_user, grant_type: grant_type).to_h).to eq({
        access_token: "an access_token"
      })
    end
  end

  describe "#refresh_token!" do
    let(:refresh_token) { "a refresh_token" }
    let(:request_body) {
      {
        grant_type: 'refresh_token',
        refresh_token: refresh_token,
        access_type: nil
      }
    }
    it "returns a token" do
      expect(subject.refresh_token!(refresh_token: refresh_token).to_h).to eq({
        access_token: "an access_token"
      })
    end
  end
end
