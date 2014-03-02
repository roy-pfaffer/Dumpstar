class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :activity_id
      t.string :type
      t.integer :value
    end
  end
end
