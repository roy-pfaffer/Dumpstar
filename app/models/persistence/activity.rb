module Persistence
  class Activity < ActiveRecord::Base
    has_many :program_activities, class_name: 'Persistence::ProgramActivity'
    has_many :programs, through: :program_activities, class_name: 'Persistence::Program'
    has_many :metrics, class_name: 'Persistence::Metric'
  end
end
