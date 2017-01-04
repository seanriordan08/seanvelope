class BasinMetrics::Well < ActiveRecord::Base

  belongs_to :customers, :class_name => 'BasinMetrics::Customer'
  belongs_to :districts, :class_name => 'BasinMetrics::District'

  has_many :parts, :class_name => 'BasinMetrics::Part', dependent: :destroy

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
  validates :pump_running, inclusion: [ true, false ]
  validates :cemented, inclusion: [ true, false ]
  validates :customer_id, presence: true
  validates :district_id, presence: true

end
