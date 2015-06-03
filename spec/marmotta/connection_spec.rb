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
      subject.delete_all

      expect(WebMock).to have_requested(:delete, "http://localhost:8983/marmotta/context/#{context}")
    end
  end

  describe "#get" do
    it "should request the resource" do
      resource_uri = "http://localhost:40/1"
      subject.get(resource_uri)

      expect(WebMock).to have_requested(:get, "#{uri}/resource?uri=#{resource_uri}")
    end
    it "should return an RDF::Enumerable" do
      expect(subject.get("http://localhost:40/1")).to be_kind_of RDF::Enumerable
    end
  end

  describe "#delete" do
    it "should delete the given resource" do
      graph = RDF::Graph.new << RDF::Statement.new(RDF::URI("http://localhost:40/1"), RDF::DC.title, "Test")
      subject.post(graph)
      subject.delete("http://localhost:40/1")

      expect(subject.get("http://localhost:40/1").statements.to_a.length).to eq 0
    end
  end

  describe "#post" do
    it "should be able to add a graph" do
      graph = RDF::Graph.new << RDF::Statement.new(RDF::URI("http://localhost:40/1"), RDF::DC.title, "Test")

      subject.post(graph)

      expect(subject.get("http://localhost:40/1").statements.first.object).to eq "Test"
    end
    it "should return true" do
      expect(subject.post(RDF::Graph.new)).to eq true
    end
  end
end
