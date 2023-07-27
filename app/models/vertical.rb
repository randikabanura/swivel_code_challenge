class Vertical < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  has_many :categories, dependent: :destroy
  has_many :courses, through: :categories
end
