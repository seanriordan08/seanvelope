class AddDirectionsToWells < ActiveRecord::Migration
  def change
    add_column :wells, :directions, :string
  end
end
