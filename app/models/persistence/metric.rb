module Persistence
  class Metric < ActiveRecord::Base
    belongs_to :activity, class_name: 'Persistence::Activity'
    self.inheritance_column = :_type_disabled
  end
end
