class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :uid
      t.string :url
      t.json :body
      t.string :provider
      t.timestamps
    end
  end
end
