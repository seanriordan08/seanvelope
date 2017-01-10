class BasinMetrics::District < ActiveRecord::Base

  belongs_to :company
  has_many :wells, :class_name => 'BasinMetrics::Well', dependent: :destroy
  has_many :customers, :class_name => 'BasinMetrics::Customer', through: :wells

  validates :name, presence: true

end
