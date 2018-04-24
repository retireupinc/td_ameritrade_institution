require "spec_helper"

RSpec.describe TDAmeritradeInstitution::Models::Base do
  class ParentModel < described_class
  end

  class ChildModel < described_class
    model(:required_parent, required: true, modeled_by: ParentModel)
    model(:not_required_parent, required: false, modeled_by: ParentModel)
    attribute(:with_default) { "default" }
    attribute(:without_default)
  end
  subject { ChildModel.new(params) }
  let(:parent_instance) { ParentModel.new }
  let(:params) { {required_parent: parent_instance} }

  describe ".new" do
    it "sets the attributes on the instance" do
      expect(subject.required_parent).to eql(parent_instance)
    end

    it "runs the default block if no value is provided" do
      expect(subject.with_default).to eq("default")
    end

    it "returns nil if no default block is provided" do
      expect(subject.without_default).to eq(nil)
    end

    context "with provided params" do
      let(:params) {
        {
          required_parent: parent_instance,
          with_default: "overridden",
          without_default: "provided"
        }
      }

      it "runs the default block if no value is provided" do
        expect(subject.with_default).to eq("overridden")
      end

      it "returns nil if no default block is provided" do
        expect(subject.without_default).to eq("provided")
      end
    end

    context "without all required models" do
      let(:params) { {} }

      it "raises an error" do
        expect { subject }.to raise_error(described_class::ModelError)
      end
    end
  end
end
