require './app'
require 'sinatra/activerecord/rake'
require 'gnip-stream'

desc 'open GNIP stream'
task :stream do
  twitter_stream = GnipStream::PowertrackClient.new(ENV['GNIP_URL'], ENV['GNIP_USERNAME'], ENV['GNIP_PASSWORD'])
  twitter_stream.consume { |message|
    parsed_message = TweetParser.new(message).parse
    activity = Persistence::Activity.create(parsed_message)
    ActivityProgramAssociator.new(activity).associate
    TweetMetricExtractor.new(activity).extract
  }
end
