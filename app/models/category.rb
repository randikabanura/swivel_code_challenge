class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }

  belongs_to :vertical
  has_many :courses
end
