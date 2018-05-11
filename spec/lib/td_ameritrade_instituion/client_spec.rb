require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Client do
  let(:access_token) { "" }
  subject { described_class.new(access_token: access_token) }


  shared_examples_for :request_forwarder do |meth, klass|
    let(:dub) { instance_double(klass, call: "a value") }
    let(:params) { {any: :params} }

    before do
      expect(klass).to receive(:new).with(params.merge(access_token: access_token)).and_return(dub)
    end

    it "sets #{meth} for config" do
      expect(subject.send(meth, params)).to eq "a value"
    end
  end

  it_behaves_like :request_forwarder, "account_number", TDAmeritradeInstitution::Requests::AccountNumbers::Create
  it_behaves_like :request_forwarder, "create_account", TDAmeritradeInstitution::Requests::Accounts::Create
end
