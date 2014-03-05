class TweetMetricExtractor
  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  def extract
    puts 'extracting'
    extract_followers_count
    extract_favorites_count
    extract_retweets_count
  end

  def extract_followers_count
    puts activity.id
    followers_count = activity.body.try(:[], 'actor').try(:[], 'followersCount') || 0
    Persistence::Metric.create(
      type: 'followers',
      value: followers_count,
      activity_id: activity.id
    )
  end

  def extract_favorites_count
    Persistence::Metric.create(
      type: 'favorites',
      value: activity.body['favoritesCount'],
      activity_id: activity.id
    )
  end

  def extract_retweets_count
    Persistence::Metric.create(
      type: 'retweets',
      value: activity.body['retweetCount'],
      activity_id: activity.id
    )
  end
end
