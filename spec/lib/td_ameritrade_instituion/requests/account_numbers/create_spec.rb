require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Requests::AccountNumbers::Create do
  let(:access_token) { "access_token" }
  let(:rep_code) { "a rep_code" }
  let(:account_segment) { "a account_segment" }
  let(:description) { "a description" }
  let(:response_headers) { {} }
  let(:response_status) { 200 }
  let(:xml_request_body) { Regexp.new("(?:([#{rep_code}]))(?:([#{description}]))(?:([#{account_segment}]))") }
  let(:response_body) { "<?xml version=\"1.0\"?>\n<xml_node>Text</xml_node>\n" }
  subject {
    described_class.new(
      access_token: access_token,
      rep_code: rep_code,
      account_segment: account_segment,
      description: description
    )
  }

  before do
    TDAmeritradeInstitution.configure do |config|
      config.api_url = "https://www.example.com"
    end
  end

  after do
    TDAmeritradeInstitution.config = nil
  end

  describe "#call" do
    before do
      stub_request(:post, "https://www.example.com/inst-account-edgeapi-v1/prospective-accounts/account-id.xml").
        with(headers: {'Authorization' => "Bearer access_token"}, body: {"inputXml" => xml_request_body }).
        to_return(headers: response_headers, status: response_status, body: response_body)
    end

    it "sends a request" do
      expect(subject.call.to_s).to eq response_body
    end

    it "returns an xml document" do
      expect(subject.call).to be_instance_of(Nokogiri::XML::Document)
    end
  end
end
