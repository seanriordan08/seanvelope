class BasinMetrics::Customer < ActiveRecord::Base

  has_many :wells, :class_name => 'BasinMetrics::Well'
  has_many :districts, :class_name => 'BasinMetrics::District', through: :wells

end
