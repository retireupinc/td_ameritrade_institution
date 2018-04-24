require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Requests::Accounts::Create do
  let(:access_token) { "access_token" }
  let(:account_number) { "an account number" }
  let(:address) {
    TDAmeritradeInstitution::Models::Address.new(
      address_line_1: "7003 Summerhill Ridge Dr",
      state_code: "NC",
      city: "Charlotte",
      zip: 28105
    )
  }
  let(:phone) {
    TDAmeritradeInstitution::Models::Phone.new(number: FFaker::PhoneNumber.short_phone_number)
  }
  let(:primary_owner) {
    TDAmeritradeInstitution::Models::Owner.new(
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      email: FFaker::Internet.disposable_email,
      phone: phone
    )
  }
  let(:account) {
    TDAmeritradeInstitution::Models::Account.new(
      primary_owner: primary_owner,
      rep_code: "a rep_code",
      account_number: account_number,
      account_statements_preference: "PAPER" ,
      trade_confirmations_preference: "EMAIL",
      ieca_preference: true,
      cash_sweep_option: "Cash"
    )
  }
  let(:response_headers) { {} }
  let(:response_status) { 200 }
  let(:xml_request_body) { Regexp.new("(?:([my_user_id]))(?:([a rep_code]))(?:([#{account_number}]))") }
  let(:response_body) { "<?xml version=\"1.0\"?>\n<xml_node>Text</xml_node>\n" }
  subject {
    described_class.new(
      access_token: access_token,
      created_by: "my_user_id",
      address: address,
      accounts: [account]
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
      stub_request(:post, "https://www.example.com/inst-account-edgeapi-v1/prospective-accounts/account-application.xml").
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
