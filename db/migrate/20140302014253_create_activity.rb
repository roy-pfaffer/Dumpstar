class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.json :body
      t.string :uid
      t.string :url
      t.string :provider
      t.timestamps
    end
  end
end
