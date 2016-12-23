class BasinMetrics::Well < ActiveRecord::Base

  belongs_to :basin_metrics_customers, :class_name => 'BasinMetrics::Customer'
  belongs_to :basin_metrics_district, :class_name => 'BasinMetrics::District'

  has_many :basin_metrics_parts, :class_name => 'BasinMetrics::Part'

end
