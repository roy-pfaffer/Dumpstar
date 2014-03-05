module Persistence
  class Activity < ActiveRecord::Base
    has_many :program_activities, class_name: 'Persistence::ProgramActivity'
    has_many :programs, through: :program_activities, class_name: 'Persistence::Program'
    has_many :metrics, class_name: 'Persistence::Metric'

    def followers_count
      metric = metrics.select{|m| m.type == 'followers'}.first
      if metric; metric.value; else; 0; end
    end

    def favorites_count
      metric = metrics.select{|m| m.type == 'favorites'}.first
      if metric; metric.value; else; 0; end
    end

    def retweets_count
      metric = metrics.select{|m| m.type == 'retweets'}.first
      if metric; metric.value; else; 0; end
    end
  end
end
