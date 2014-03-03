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

get '/master-feed' do
  content_type :json

  filter = ActivityFilter.new(
    program: Persistence::Program.where(bossanova_id: params[:program_id].to_i).first,
    date_range: params[:date_range],
    sort_key: params[:sort_key],
    limit: params[:limit].to_i
  )

  filter.perform.to_json
end

