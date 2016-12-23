class BasinMetrics::Part < ActiveRecord::Base

  belongs_to :basin_metrics_well, :class_name => 'BasinMetrics::Well'

end
