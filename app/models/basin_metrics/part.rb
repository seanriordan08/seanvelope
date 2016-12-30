class BasinMetrics::Part < ActiveRecord::Base
  self.inheritance_column = nil #Disable STI for 'type' column

  belongs_to :basin_metrics_well, :class_name => 'BasinMetrics::Well'

end
