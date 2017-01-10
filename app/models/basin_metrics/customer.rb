class BasinMetrics::Customer < ActiveRecord::Base

  belongs_to :company, :class_name => 'BasinMetrics::Company'
  has_many :wells, :class_name => 'BasinMetrics::Well', dependent: :destroy
  has_many :districts, :class_name => 'BasinMetrics::District', through: :wells

  validates :name, presence: true

end
