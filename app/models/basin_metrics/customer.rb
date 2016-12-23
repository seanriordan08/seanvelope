class BasinMetrics::Customer < ActiveRecord::Base

  has_many :basin_metrics_wells, :class_name => 'BasinMetrics::Well'

end
