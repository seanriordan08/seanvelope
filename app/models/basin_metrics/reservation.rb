class BasinMetrics::Reservation < ActiveRecord::Base

  belongs_to :well, :class_name => 'BasinMetrics::Well'
  belongs_to :part, :class_name => 'BasinMetrics::Part'

end
