class TweetMetricExtractor
  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  def extract
    puts 'extracting'
    extract_follower_count
    extract_retweet_count
  end

  def extract_follower_count
    Persistence::Metric.create(
      type: 'favorites',
      value: activity.body['favoritesCount'],
      activity_id: activity.id
    )
  end

  def extract_retweet_count
    Persistence::Metric.create(
      type: 'retweets',
      value: activity.body['retweetCount'],
      activity_id: activity.id
    )
  end
end
