class ActivityFilter
  attr_reader :program, :date_range, :sort_key, :limit, :last_id

  def initialize(options)
    @program = options[:program]
    @date_range = (options[:date_range] && options[:date_range].to_i.days.ago) || 30.days.ago
    @sort_key = options[:sort_key]
    @limit = options[:limit] || 30
    @last_id = options[:last_id]
  end

  def perform
    results = sort_key ? sorted_activities : scoped_activities
    limit ? results.first(limit) : results
  end

  def scoped_activities
    last_id_query = last_id ? "and activities.id > #{last_id}" : ""
    @scoped_activities ||= program.activities.where("created_at > ? #{last_id_query}", date_range).order('created_at DESC')
  end

  def sorted_activities
    @sorted_activities ||= scoped_activities.sort{|a,b| b.retweets_count <=> a.retweets_count}
  end
end
