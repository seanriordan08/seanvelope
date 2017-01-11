class RemoveWellIdFromParts < ActiveRecord::Migration
  def change
    remove_reference :parts, :well, index:true, foreign_key: true
  end
end
