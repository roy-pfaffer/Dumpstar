require 'spec_helper'

describe TweetParser do
  let(:parser) { TweetParser.new(Support::Fixtures.tweet_json_string) }

  describe '#parse' do
    it 'should return a hash with the right attributes' do
      parsed = parser.parse
      parsed[:uid].should == '2005:123456789'
      parsed[:url].should == 'http://twitter.com/someone/statuses/123456789'
      parsed[:body].should == JSON.parse(Support::Fixtures.tweet_json_string)
      parsed[:provider].should == 'twitter'
    end
  end
end
