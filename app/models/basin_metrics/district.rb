class BasinMetrics::District < ActiveRecord::Base

  has_many :wells, :class_name => 'BasinMetrics::Well'
  has_many :customers, :class_name => 'BasinMetrics::Customer', through: :wells

  validates :name, presence: true

end
