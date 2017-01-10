class BasinMetrics::Company < ActiveRecord::Base

  has_many :users
  has_many :customers, :class_name => 'BasinMetrics::Customer'
  has_many :districts, :class_name => 'BasinMetrics::District'
  has_many :wells, through: :districts
  has_many :parts, through: :wells

end