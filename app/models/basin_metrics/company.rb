class BasinMetrics::Company < ActiveRecord::Base

  has_many :users
  has_many :customers, :class_name => 'BasinMetrics::Customer'
  has_many :districts, :class_name => 'BasinMetrics::District'
  has_many :wells, :class_name => 'BasinMetrics::Well', through: :districts
  has_many :parts, :class_name => 'BasinMetrics::Part', through: :districts

end