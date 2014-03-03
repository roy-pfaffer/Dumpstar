ENV['RACK_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rspec'
Dir[File.dirname(__FILE__) + "/support/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.color_enabled = "true"
  config.order = "random"
end

Spec::Runner.configure do |config|
  config.before(:all) do
    ActiveRecord::Base.subclasses.each { |subclass| subclass.delete_all }
  end
end
