class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.string :number, null: false
      t.string :size
      t.integer :quantity, default: 0
      t.integer :revenue, default: 0
      t.datetime  :date_sold, default: DateTime.now
      t.integer :well_id

      t.timestamps null: false
    end
  end
end
