class AddPercentCompleteToWells < ActiveRecord::Migration
  def change
    add_column :wells, :percent_complete, :integer, default: 0
  end
end
