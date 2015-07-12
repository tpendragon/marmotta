require "marmotta/version"
require "hurley"
require "rdf"
require "json/ld"
require "sparql/client"

module Marmotta
  autoload :Connection, 'marmotta/connection'
  autoload :Resource, 'marmotta/resource'
  autoload :MaybeGraphResult, 'marmotta/maybe_graph_result'
  autoload :LdPathQuery, 'marmotta/ld_path_query'
  autoload :LdPathConnection, 'marmotta/ld_path_connection'
end
