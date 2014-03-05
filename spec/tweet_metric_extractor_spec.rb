require 'spec_helper'

describe TweetMetricExtractor do
  let(:extractor) { TweetMetricExtractor.new(tweet) }
  let(:tweet) { double('tweet', id: 42, body: { 'favoritesCount' => 4, 'retweetCount' => 2, 'actor' => { 'followersCount' => 27 } }) }
  let(:followers_metric) { Persistence::Metric.where(type: 'followers') }
  let(:favorites_metrics) { Persistence::Metric.where(type: 'favorites') }
  let(:retweets_metrics) { Persistence::Metric.where(type: 'retweets') }

  before(:each) { extractor.extract }
  after(:each) { Persistence::Metric.delete_all }

  describe '#extract' do
    it "should extract the followers count from the tweet and store it in the database" do
      followers_metric.count.should == 1
      followers_metric.first.type.should == 'followers'
      followers_metric.first.value.should == 27
      followers_metric.first.activity_id.should == 42
    end

    it "should extract the favorites count from the tweet and store it in the database" do
      favorites_metrics.count.should == 1
      favorites_metrics.first.type.should == 'favorites'
      favorites_metrics.first.value.should == 4
      favorites_metrics.first.activity_id.should == 42
    end

    it "should extract the reshare count from the tweet and store it in the database" do
      retweets_metrics.count.should == 1
      retweets_metrics.first.type.should == 'retweets'
      retweets_metrics.first.value.should == 2
      retweets_metrics.first.activity_id.should == 42
    end
  end
end
