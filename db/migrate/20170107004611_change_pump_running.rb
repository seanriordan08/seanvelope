class ChangePumpRunning < ActiveRecord::Migration
  def change
    remove_column :wells, :pump_running, :boolean
    add_column :wells, :pump_down_ring, :string
  end
end
