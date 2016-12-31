class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.string :number, null: false
      t.string :size
      t.integer :quantity, default: 1
      t.integer :revenue, default: 0
      t.datetime  :date_sold, default: '2016-12-30 00:00:00'
      t.references :well, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
