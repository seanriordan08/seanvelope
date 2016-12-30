class BasinMetrics::Well < ActiveRecord::Base

  belongs_to :basin_metrics_customers, :class_name => 'BasinMetrics::Customer'
  belongs_to :basin_metrics_district, :class_name => 'BasinMetrics::District'

  has_many :basin_metrics_parts, :class_name => 'BasinMetrics::Part', inverse_of: :parts

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
  validates :pump_running, inclusion: [ true, false ]
  validates :cemented, inclusion: [ true, false ]

  validates :customer_id, presence: true
  validates :district_id, presence: true

end
