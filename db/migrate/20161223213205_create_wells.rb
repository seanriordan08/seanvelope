class CreateWells < ActiveRecord::Migration
  def change
    create_table :wells do |t|
      t.string :name, null: false
      t.string :number, null: false
      t.boolean :pump_running, default: false, null: false
      t.boolean :cemented, default: false, null: false
      t.integer :revenue
      t.integer :customer_id, null: false
      t.integer :district_id, null: false
      t.index [:customer_id, :district_id]
      t.boolean :complete, default: false
      t.string :comments

      t.timestamps null: false
    end
  end
end
