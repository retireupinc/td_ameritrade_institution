require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Requester do
  class FakeRequesterClass
    include TDAmeritradeInstitution::Requester
  end
  subject { FakeRequesterClass.new }
  let(:request_endpoint) { "https://www.example.com/hello" }
  let(:response_status) { 200 }
  let(:response_body) { {}.to_json }
  let(:response_headers) { {} }

  describe "#get" do
    before do
      stub_request(:get, request_endpoint).
        with(headers: {"Content-Type" => "bananas"}).
        to_return(status: response_status, headers: response_headers, body: response_body)
    end

    it "requests to the endpoint" do
      response = subject.get(
        url: request_endpoint,
        headers: {"Content-Type" => "bananas"}
      )
      expect(response).to be_success
    end

    context "bad request" do
      let(:response_status) { 400 }

      it "raises an error" do
        expect {
          subject.get(
            url: request_endpoint,
            headers: {"Content-Type" => "bananas"}
          )
        }.to raise_error(TDAmeritradeInstitution::RequestError)
      end
    end
  end

  describe "#post" do
    let(:request_body) { {a_request: :body}.to_json }
    before do
      stub_request(:post, request_endpoint).
        with(headers: {"Content-Type" => "bananas"}, body: request_body).
        to_return(status: response_status, headers: response_headers, body: response_body)
    end

    it "requests to the endpoint" do
      response = subject.post(
        url: request_endpoint,
        headers: {"Content-Type" => "bananas"},
        body: request_body
      )
      expect(response).to be_success
    end

    context "bad request" do
      let(:response_status) { 400 }

      it "raises an error" do
        expect {
          subject.post(
            url: request_endpoint,
            headers: {"Content-Type" => "bananas"},
            body: request_body
          )
        }.to raise_error(TDAmeritradeInstitution::RequestError)
      end
    end
  end
end
