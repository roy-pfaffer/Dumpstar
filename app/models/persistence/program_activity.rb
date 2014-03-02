module Persistence
  class ProgramActivity < ActiveRecord::Base
    belongs_to :program, class_name: 'Persistence::Program'
    belongs_to :activity, class_name: 'Persistence::Activity'
  end
end
