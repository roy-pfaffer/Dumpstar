class ActivityProgramAssociator
  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  def associate
    associated_programs.each do |program|
      Persistence::ProgramActivity.create(program_id: program.id, activity_id: activity.id)
    end
  end

  private

  def associated_programs
    @associated_programs ||= Persistence::Program.where("keywords && '{#{activity_text}}'::character varying[]")
  end

  def activity_text
    if activity.body['body']
      activity.body['body'].tr('^A-Za-z0-9 ', '').strip.downcase.gsub(/\s+/, ',')
    else
      ""
    end
  end
end
