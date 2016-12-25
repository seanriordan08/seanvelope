class BasinMetrics::Part < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :basin_metrics_well, :class_name => 'BasinMetrics::Well'

end
