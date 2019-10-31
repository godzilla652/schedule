class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :faculty_id

      t.timestamps
    end
  end
end
