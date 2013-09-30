require 'minitest/autorun'
require 'minitest/reporters'

require 'ostruct'
require 'pry'
require 'webmock'
include WebMock::API


# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Set up minitest
MiniTest::Reporters.use!

require 'mocha/setup'
require File.expand_path("../../lib/hungrytable.rb", __FILE__)
