module Marmotta
  class LdPathConnection
    attr_reader :connection, :uri
    # @param [Hurley::Client] connection A client to use for running queries.
    # @param [String, #to_s] An LDPath to run
    def initialize(connection, uri)
      @connection = connection
      @uri = uri.to_s
    end

    def get(path)
      result = connection.get(api_path) do |req|
        req.query[:uri] = uri
        req.query[:path] = path.to_s
        req.query.delete(:graph)
        req.header = {}
      end
      if result.status_code == 200
        JSON.parse(result.body)
      else
        {}
      end
    end

    private

    def api_path
      "ldpath/path"
    end
  end
end
