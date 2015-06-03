require 'pathname'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir[Pathname.new(__dir__).join("support/**/*.rb")].each { |f| require f }
require 'marmotta'
