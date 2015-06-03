##
# Encapsulates how to handle turning a Hurley result into an RDF::Graph.
class MaybeGraphResult
  attr_reader :result

  # @param [Hurley::Response] result A web response object.
  def initialize(result)
    @result = result
  end

  def value
    if graph?
      parsed_graph
    else
      RDF::Graph.new
    end
  end

  private

  def graph?
    result.success?
  end

  def parsed_graph
    JSON::LD::Reader.new(result.body)
  end
end
