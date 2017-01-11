class BasinMetrics::District < ActiveRecord::Base

  belongs_to :company, :class_name => 'BasinMetrics::Company'

  has_many :wells, :class_name => 'BasinMetrics::Well', dependent: :destroy
  has_many :customers, :class_name => 'BasinMetrics::Customer', through: :wells
  has_many :parts, :class_name => 'BasinMetrics::Part', dependent: :destroy

  validates :name, presence: true

end
