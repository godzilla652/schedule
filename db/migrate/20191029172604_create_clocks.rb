class CreateClocks < ActiveRecord::Migration[6.0]
  def change
    create_table :clocks do |t|
      t.string :name

      t.timestamps
    end
  end
end
