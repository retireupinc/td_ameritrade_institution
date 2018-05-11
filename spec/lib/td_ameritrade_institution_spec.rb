require "spec_helper"

RSpec.describe TDAmeritradeInstitution do
  it "has a version number" do
    expect(TDAmeritradeInstitution::VERSION).not_to be nil
  end

  shared_examples_for :config_variable_setter do |meth, val|
    after do
      described_class.config = nil
    end

    it "sets #{meth} for config" do
      described_class.configure do |config|
        config.send("#{meth}=", val)
      end
      expect(described_class.config.send(meth)).to eq val
    end
  end

  it_behaves_like :config_variable_setter, "api_url", "a value"
  it_behaves_like :config_variable_setter, "token_url", "a value"
  it_behaves_like :config_variable_setter, "client_id", "a value"
  it_behaves_like :config_variable_setter, "client_secret", "a value"
end
