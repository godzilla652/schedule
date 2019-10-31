class CreateScheduls < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduls do |t|
      t.integer :group_id
      t.integer :day_id
      t.integer :clock_id
      t.boolean :even, default: false
      t.boolean :odd, default: false
      t.string :teacher
      t.string :course
      t.string :room

      t.timestamps
    end
  end
end
