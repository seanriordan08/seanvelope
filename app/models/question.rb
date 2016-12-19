class Question < ActiveRecord::Base

  validates :question, presence: true
  validates :email, presence: true
end
