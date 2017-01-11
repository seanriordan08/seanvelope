class AddDistrictToParts < ActiveRecord::Migration
  def change
    add_reference :parts, :district, index: true, foreign_key: true
  end
end
