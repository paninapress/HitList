class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.date :date
      t.string :type
      t.integer :rating
      t.text :comment
      t.references :friend, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
