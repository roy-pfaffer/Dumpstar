class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :bossanova_id
      t.string :keywords, array: true, default: []
      t.timestamps
    end
  end
end
