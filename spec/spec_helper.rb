require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rspec'
Dir[File.dirname(__FILE__) + "/support/*.rb"].each {|f| require f}

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.color_enabled = "true"
  config.order = "random"
end
