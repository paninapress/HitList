class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name, null: false, limit: 50
      t.integer :category
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
