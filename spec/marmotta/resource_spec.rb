require 'spec_helper'

RSpec.describe Marmotta::Resource do
  subject { described_class.new(resource_uri, connection: connection) }
  before do
    connection.delete_all
  end
  let(:connection) { Marmotta::Connection.new(uri: uri, context: context) }
  let(:uri) { "http://localhost:8983/marmotta" }
  let(:context) { "test" }
  let(:resource_uri) { RDF::URI("http://opaquenamespace.org/ns/1") }
  let(:graph) do
    g = RDF::Graph.new
    g << [resource_uri, RDF::DC.title, "Title"]
    g
  end

  describe "#post" do
    it "should update the resource" do
      subject.post(graph)

      expect(subject.get.statements.to_a).to eq [RDF::Statement.new(resource_uri, RDF::DC.title, "Title")]
    end
  end

  describe "#delete" do
    it "should delete it" do
      subject.post(graph)
      expect(subject.get.statements.to_a.length).to eq 1
      subject.delete

      expect(subject.get.statements.to_a.length).to eq 0
    end
  end

  describe "#get" do
    it "should not error" do
      expect{subject.get}.not_to raise_error
    end
    it "should return a graph" do
      expect(subject.get).to be_kind_of RDF::Enumerable
    end
  end
end
