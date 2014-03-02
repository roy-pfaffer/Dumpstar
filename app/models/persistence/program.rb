module Persistence
  class Program < ActiveRecord::Base
    has_many :program_activities, class_name: 'Persistence::ProgramActivity'
    has_many :activities, through: :program_activities, class_name: 'Persistence::Activity'
  end
end
