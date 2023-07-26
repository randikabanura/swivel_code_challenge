class Course < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }

  belongs_to :category
end
