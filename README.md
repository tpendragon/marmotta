# Marmotta
[![Circle CI](https://circleci.com/gh/terrellt/marmotta.svg?style=svg)](https://circleci.com/gh/terrellt/marmotta)

Marmotta is a small ruby client to abstract away interacting with the [Apache
Marmotta](http://marmotta.apache.org/) server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marmotta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marmotta

## Usage

### Connection

```ruby
# Initialize Marmotta with a URI and a context.
# The context defines the named graph triples will be posted to and which one
# will be deleted when #delete_all is called.
connection = Marmotta::Connection.new(uri: "http://localhost:8983/marmotta", context: "test")

connection.delete_all # Empty out the "test" context.

# Request this URI - Marmotta will use LDCache if configured, automatically
# going out and getting the triples which resolve at this URI.
graph = connection.get("http://id.loc.gov/authorities/names/n80017721")

# Add the triples in the graph to the "test" context. Works with any
# RDF::Enumerable
connection.post(graph)
```

### Resource

A resource stores which subject URI you're requesting and abstracts out the
connection details.

```ruby
# You need a connection
connection = Marmotta::Connection.new(uri: "http://localhost:8983/marmotta", context: "test")

resource = Marmotta::Resource.new("http://id.loc.gov/authorities/names/n80017721", connection: connection)

resulting_graph = resource.get # Get the graph for this resource - equivalent to connection.get(uri)

resource.delete # Delete this resource from Marmotta - equivalent to connection.delete(uri)

resource.post(graph) # Post a graph to the connection associated with this URI. Currently it does not enforce any subject requirements on the graph that's posted, so it's exactly equivalent to connection.post(graph)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To start Marmotta run `rake jetty:start`

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/marmotta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
