class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :number
      t.integer :department_id

      t.timestamps
    end
  end
end
