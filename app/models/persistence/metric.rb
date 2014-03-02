module Persistence
  class Metric < ActiveRecord::Base
    belongs_to :activity, class_name: 'Persistence::Activity'
  end
end
