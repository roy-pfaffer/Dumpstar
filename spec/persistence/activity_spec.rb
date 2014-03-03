require 'spec_helper'

describe Persistence::Activity do
  let!(:activity) { Persistence::Activity.new }
  let!(:metrics) {
    activity.metrics << Persistence::Metric.create(type: 'favorites', value: 23)
    activity.metrics << Persistence::Metric.create(type: 'retweets', value: 12)
    activity.metrics
  }

  describe '#retweets_count' do
    it 'should return the number of retweets the activity has' do
      activity.retweets_count.should == 12
    end

    it 'should return zero if the metric does not exist' do
      activity.metrics.delete_all
      activity.retweets_count.should == 0
    end
  end

  describe '#favorites_count' do
    it 'should return the number of favorites the activity has' do
      activity.favorites_count.should == 23
    end

    it 'should return zero if the metric does not exist' do
      activity.metrics.delete_all
      activity.favorites_count.should == 0
    end
  end
end
