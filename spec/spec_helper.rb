require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rspec'

# require files to test
model_dir = "#{File.dirname(__FILE__)}/../app/models"
$: << model_dir

require "some_class"

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.color_enabled = "true"
  config.order = "random"
end
