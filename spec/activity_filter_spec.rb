require 'spec_helper'
require 'pry'

describe ActivityFilter do
  let(:filter) { ActivityFilter.new(initialization_params) }
  let(:initialization_params) { {
    program: program,
    date_range: 12.days.ago,
    sort_key: sort_key
  } }
  let(:program) {
    program = Persistence::Program.create
    program.activities << activities
    program
  }
  let(:sort_key) { nil }
  let(:activities) {
    collection = [
      Persistence::Activity.create(created_at: 5.days.ago),
      Persistence::Activity.create(created_at: 10.days.ago),
      Persistence::Activity.create(created_at: 15.days.ago) ]
    Persistence::Metric.create(activity_id: collection[0].id, type: 'retweets', value: 20)
    Persistence::Metric.create(activity_id: collection[1].id, type: 'retweets', value: 30)
    Persistence::Metric.create(activity_id: collection[2].id, type: 'retweets', value: 10)
    collection
  }

  describe '#perform' do
    context 'there is no sorted_by parameter provided' do
      it 'should return return an array of activities sorted chronologically, scoped to the given date range' do
        filter.perform.should == [activities[0], activities[1]]
      end
    end

    context 'activities are sorted by a specific metric' do
      let(:sort_key) { 'retweets' }
      it 'should return an array of activities sorted by the provided metric (retweets), scoped to the given date range' do
        filter.perform.should == [activities[1], activities[0]]
      end
    end
  end
end
