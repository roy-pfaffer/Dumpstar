require 'spec_helper'

describe ActivityProgramAssociator do
  let(:associator) { ActivityProgramAssociator.new(activity) }

  let!(:activity) { double('tweet', id: 42, body: { "body" => 'This is a test word3' }) }

  let!(:programs) {
    Persistence::Program.delete_all
    [Persistence::Program.create(keywords: ['word1', 'word2']),
    Persistence::Program.create(keywords: ['word3', 'word4'])]
  }

  describe '#associate' do
    it "should associate an activity with all programs that have keywords in the activity's text" do
      Persistence::ProgramActivity.should_receive(:create).with(program_id: programs[1].id, activity_id: activity.id)
      associator.associate
    end
  end
end

