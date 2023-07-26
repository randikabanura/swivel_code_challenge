class Vertical < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }

  has_many :categories
  has_many :courses, through: :categories
end
