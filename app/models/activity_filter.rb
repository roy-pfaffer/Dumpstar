class ActivityFilter
  attr_reader :program, :date_range, :sort_key, :limit, :last_id

  def initialize(options)
    @program = options[:program]
    @date_range = (options[:date_range] && options[:date_range] || 30).to_i.days.ago
    @sort_key = options[:sort_key]
    @limit = (options[:limit] || 30).to_i
    @last_id = options[:last_id]
  end

  def perform
    results = sort_key ? sorted_activities : scoped_activities
    limit ? results.last(limit) : results
  end

  def scoped_activities
    last_id_query = last_id ? "and activities.id > #{last_id}" : ""
    @scoped_activities ||= program.activities.where("created_at > ? #{last_id_query}", date_range).order('created_at ASC')
  end

  def sorted_activities
    sort_metric = "#{sort_key}_count"
    @sorted_activities ||= scoped_activities.sort{|a,b| a.send(sort_metric) <=> b.send(sort_metric) }
  end
end
