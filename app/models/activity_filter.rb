class ActivityFilter
  attr_reader :program, :date_range, :sort_key

  def initialize(options)
    @program = options[:program]
    @date_range = options[:date_range] || 30.days.ago
    @sort_key = options[:sort_key]
  end

  def perform
    sort_key ? sorted_activities : scoped_activities
  end

  private

  def scoped_activities
    @scoped_activities ||= program.activities.where("created_at > ?", date_range).order('created_at DESC')
  end

  def sorted_activities
    @sorted_activities ||=
      scoped_activities
        .sort{|a,b| b.retweets_count <=> a.retweets_count}
  end
end
