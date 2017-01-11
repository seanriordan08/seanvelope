class BasinMetrics::Part < ActiveRecord::Base
  self.inheritance_column = nil #Disable STI for 'type' column

  belongs_to :district, :class_name => 'BasinMetrics::District'

  has_many :reservations, :class_name => 'BasinMetrics::Reservation'
  has_many :wells, :class_name => 'BasinMetrics::Well', through: :reservations

  validates :name, presence: true
  validates :type, presence: true
  validates :number, presence: true
  validates :order, presence: true, uniqueness: true
  validates :quantity, presence: true, numericality: :only_integer

  validates :district_id, presence: true

end
