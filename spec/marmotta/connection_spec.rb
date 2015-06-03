require 'spec_helper'

RSpec.describe Marmotta::Connection do
  subject { described_class.new(uri: uri, context: context)}
  let(:uri) { "http://localhost:8983/marmotta" }
  let(:context) { "test" }

  describe "#delete_all" do
    it "should not error" do
      expect{subject.delete_all}.not_to raise_error
    end
    it "should request Marmotta" do
      expect(WebMock).to have_requested(:delete, "http://localhost:8983/marmotta/context/#{context}")
    end
  end
end
