require 'spec_helper'

RSpec.describe Marmotta::LdPathConnection do
  subject { described_class.new(connection, uri) }
  let(:connection) { Marmotta::Connection.new(uri: "http://localhost:8983/marmotta").send(:connection) }
  let(:path) { RDF::URI("<http://www.w3.org/2004/02/skos/core#altLabel>") }
  let(:uri) { "http://bla.bla.org"  }
  describe "#get" do
    it "should return a JSON of the result" do
      result = {"test" => 1}
      stub_request(:get, "http://localhost:8983/marmotta/ldpath/path?path=%3Chttp://www.w3.org/2004/02/skos/core%23altLabel%3E&uri=http://bla.bla.org").
        to_return(:status => 200, :body => result.to_json, :headers => {})

      response = subject.get(path)

      expect(response).to eq result
    end
  end
end
