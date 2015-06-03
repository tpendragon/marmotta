require "marmotta/version"
require "hurley"
require "rdf"
require "json/ld"
require "sparql/client"

module Marmotta
  autoload :Connection, 'marmotta/connection'
  autoload :Resource, 'marmotta/resource'
  autoload :MaybeGraphResult, 'marmotta/maybe_graph_result'
end
