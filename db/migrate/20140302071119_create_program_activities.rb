class CreateProgramActivities < ActiveRecord::Migration
  def change
    create_table :program_activities do |t|
      t.integer :program_id
      t.integer :activity_id
    end
  end
end
