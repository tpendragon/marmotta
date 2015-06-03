module Marmotta
  class Resource
    attr_reader :subject_uri, :connection
    def initialize(subject_uri, connection:)
      @subject_uri = subject_uri
      @connection = connection
    end

    def delete
      connection.delete(subject_uri)
    end

    def get
      connection.get(subject_uri)
    end

    def post(graph)
      connection.post(graph)
    end
  end
end
