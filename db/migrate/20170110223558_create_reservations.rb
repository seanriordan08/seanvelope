class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :well, index: true, foreign_key: true
      t.references :part, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
