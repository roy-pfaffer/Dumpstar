require 'spec_helper'

describe ActivityFilter do
  let(:filter) { ActivityFilter.new(initialization_params) }
  let(:initialization_params) { {
    program: program,
    date_range: date_range,
    sort_key: sort_key,
    limit: limit,
    last_id: last_id
  } }
  let(:program) {
    program = Persistence::Program.create
    program.activities << activities
    program
  }
  let(:date_range) { 12 }
  let(:sort_key) { nil }
  let(:limit) { nil }
  let(:last_id) { nil }
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

    context 'limit parameter is provided' do
      let(:limit) { 1 }
      it 'should limit the number of activities to the limit provided' do
        filter.perform.count.should == limit
      end
    end

    context 'last_id parameter is provided' do
      let(:last_id) { Persistence::Activity.last(2)[0].id }
      let(:date_range) { 20 }

      it 'should only send back activities greater than the one provided' do
        results = filter.perform
        results.count.should == 1
        results.first.id.should == activities[2].id
      end
    end
  end
end
