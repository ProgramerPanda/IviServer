class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, index: true
      t.string :location
      t.string :describe
      t.integer :discount
      t.string :store

      t.timestamps
    end
  end
end
