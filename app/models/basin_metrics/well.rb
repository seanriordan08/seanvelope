class BasinMetrics::Well < ActiveRecord::Base

  belongs_to :customer, :class_name => 'BasinMetrics::Customer'
  belongs_to :district, :class_name => 'BasinMetrics::District'

  has_many :reservations, :class_name => 'BasinMetrics::Reservation'
  has_many :parts, :class_name => 'BasinMetrics::Part', through: :reservations

  HUMANIZED_ATTRIBUTES = {est_start: 'Estimated Start Date', est_end: 'Estimated End Date', actual_start: 'Actual Start Date', completed: 'Completion Date'}

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
  validates :cemented, inclusion: [ true, false ]
  validates :customer_id, presence: true
  validates :district_id, presence: true
  validates :est_start, date: { allow_blank: true, after_or_equal_to: Proc.new { Date.today }, message: 'must ON or AFTER today' }
  validates :est_end, date: { allow_blank: true, after_or_equal_to: :est_start }

  validates :actual_start, date: { allow_blank: true, before_or_equal_to: Proc.new { Date.today }, message: 'must ON or BEFORE today' }
  validate :completion

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def completion
    return if completed.blank?

    if actual_start.blank?
      errors.add(:completed, 'must first have an Actual Start Date')
    elsif completed < actual_start
      errors.add(:completed, 'must be ON or AFTER the Actual Start Date')
    elsif completed > Date.today
      errors.add(:completed, 'must ON or BEFORE today')
    end
  end

end
