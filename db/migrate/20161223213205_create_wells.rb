class CreateWells < ActiveRecord::Migration
  def change
    create_table :wells do |t|
      t.string :name, null: false
      t.string :number, null: false
      t.datetime :work_start
      t.datetime :work_duration
      t.boolean :pump_running, default: false, null: false
      t.boolean :cemented, default: false, null: false
      t.integer :revenue, default: 0
      t.boolean :complete, default: false
      t.string :comments
      t.references :customer, index: true, foreign_key: true
      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
