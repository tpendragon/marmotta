module Marmotta
  class LdPathConnection
    attr_reader :connection, :path
    # @param [Hurley::Client] connection A client to use for running queries.
    # @param [String, #to_s] An LDPath to run
    def initialize(connection, path)
      @connection = connection
      @path = path.to_s
    end

    def get(uri)
      result = connection.get(api_path) do |req|
        req.query[:uri] = uri.to_s
        req.query[:path] = path
        req.query.delete(:graph)
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
