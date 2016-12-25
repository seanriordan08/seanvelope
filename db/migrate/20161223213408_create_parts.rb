class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :size
      t.string :units

      t.timestamps null: false
    end
  end
end
