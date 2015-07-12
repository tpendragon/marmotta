module Marmotta
  class Connection
    attr_reader :uri, :context
    def initialize(uri:, context: "default")
      @uri = uri
      @context = context
    end

    def delete_all
      connection.delete("context/#{context}") do |c|
        c.query.delete(:graph)
      end
    end

    # Returns an RDFSource represented by the resource URI.
    # @param [String, #to_s] resource_uri URI to request
    # @return [RDF::Graph] The resulting graph
    def get(resource_uri)
      result = connection.get("resource") do |request|
        request.query[:uri] = resource_uri.to_s
        request.query.delete(:graph)
      end
      MaybeGraphResult.new(result).value
    end

    # Posts a graph to Marmotta in the appropriate context.
    # @param [RDF::Enumerable] graph The graph to post.
    # @return [True, False] Result of posting.
    def post(graph)
      sparql_update_client.insert_data(graph, :graph => context_uri.to_s)
      true
    end

    # Deletes a subject from the context.
    # @param [String, #to_s] resource_uri URI of resource to delete.
    # @return [True, False] Result of deleting.
    # @todo Should this only delete triples from the given context?
    def delete(resource_uri)
      connection.delete("resource") do |request|
        request.query[:uri] = resource_uri.to_s
        request.query.delete(:graph)
      end
    end

    # Returns an LDPath connection for a given path.
    # @param [String, #to_s] path LDPath query to run
    # @return [LdPathConnection] Connection which will run that path query.
    def ldpath(path)
      LdPathConnection.new(connection, path)
    end

    private

    def connection
      @connection ||= ::Hurley::Client.new(uri).tap do |c|
        c.header[:accept] = mime_type
        c.header[:content_type] = mime_type
        c.query[:graph] = context_uri.to_s
      end
    end

    def sparql_update_client
      @sparql_update_client ||= SPARQL::Client.new("#{uri}/sparql/update")
    end

    def mime_type
      "application/ld+json"
    end

    # @todo Support arbitrary non-Marmotta contexts.
    def context_uri
      ::RDF::URI("#{uri}/context/#{context}")
    end
  end
end
