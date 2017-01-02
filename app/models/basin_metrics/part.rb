class BasinMetrics::Part < ActiveRecord::Base
  self.inheritance_column = nil #Disable STI for 'type' column

  belongs_to :well, :class_name => 'BasinMetrics::Well'

  validates :name, presence: true
  validates :type, presence: true
  validates :number, presence: true
  validates :quantity, presence: true
  validates :revenue, presence: true

  validates :well_id, presence: { message: "number can't be blank" }

end
