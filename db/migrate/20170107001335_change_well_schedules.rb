class ChangeWellSchedules < ActiveRecord::Migration
  def change
    rename_column :wells, :work_start, :est_start
    rename_column :wells, :work_duration, :actual_start
    add_column :wells, :est_end, :datetime
    add_column :wells, :completed, :datetime
    remove_column :wells, :complete, :boolean
  end
end
