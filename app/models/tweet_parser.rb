class TweetParser
  attr_reader :tweet_json_string

  def initialize(tweet_json_string)
    @tweet_json_string = tweet_json_string
  end

  def parse
    {
      uid: uid,
      url: tweet_json['link'],
      body: tweet_json,
      provider: 'twitter'
    }
  end

  private

  def tweet_json
    @tweet_json ||= JSON.parse(tweet_json_string)
  rescue JSON::ParserError => e
    { error: e.to_json }
  end

  def uid
    tweet_json['id'].try(:match, /twitter.com,(.*)/).try(:[], 1)
  end
end
