require 'dotenv'
Dotenv.load

require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
Dir[File.dirname(__FILE__) + "/app/**/*.rb"].each {|file| require file }

get '/' do
  'Jazz hands!'
end

