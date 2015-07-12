require 'spec_helper'

RSpec.describe Marmotta::LdPathConnection do
  subject { described_class.new(connection, path) }
  let(:connection) { Marmotta::Connection.new(uri: "http://localhost:8983/marmotta").send(:connection) }
  let(:path) { RDF::URI("<http://www.w3.org/2004/02/skos/core#altLabel>") }
  describe "#get" do
    it "should return a JSON of the result" do
      result = {"test" => 1}
      stub_request(:get, "http://localhost:8983/marmotta/ldpath/path?path=%3Chttp://www.w3.org/2004/02/skos/core%23altLabel%3E&uri=http://bla.bla.org").
        with(:headers => {'Accept'=>'application/ld+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/ld+json', 'User-Agent'=>'Hurley v0.1'}).
        to_return(:status => 200, :body => result.to_json, :headers => {})

      response = subject.get("http://bla.bla.org")

      expect(response).to eq result
    end
  end
end