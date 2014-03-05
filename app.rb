require 'dotenv'
Dotenv.load

require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'superbolt'
Dir[File.dirname(__FILE__) + "/config/**/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/app/**/*.rb"].each {|file| require file }

get '/programs/:program_id' do
  program = Persistence::Program.where(bossanova_id: params[:program_id]).first
  erb :index, locals: { program_id: program.bossanova_id, program_name: program.name, program_keywords: program.keywords }
end

get '/programs/:program_id/stream' do
  content_type :json

  filter = ActivityFilter.new(
    program: Persistence::Program.where(bossanova_id: params[:program_id].to_i).first,
    date_range: params[:date_range],
    sort_key: params[:sort_key],
    limit: params[:limit],
    last_id: params[:last_id]
  )

  filter.perform.to_json
end

get '/programs/:program_id/activities/:activity_id/create_action' do
  activity = Persistence::Activity.find(params[:activity_id].to_i)
  Superbolt.message
    .to('activator')
    .re('action_creation')
    .send!({
      program_id: params[:program_id].to_i,
      author: activity.body['actor']['displayName'],
      prepopulated_text: activity.body['body'],
      link_url: activity.body['gnip']['urls'][0]['expanded_url'],
      type: 'link'
    })
end
