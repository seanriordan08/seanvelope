class ChangePartsDateSold < ActiveRecord::Migration
  def change
    change_column :parts, :date_sold, :datetime, default: nil
  end
end
