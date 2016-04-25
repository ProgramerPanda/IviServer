class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :location
      t.string :describe
      t.integer :discount
      t.string :store

      t.timestamps
    end
  end
end
