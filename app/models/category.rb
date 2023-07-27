class Category < ApplicationRecord
  include ValidationConcern

  belongs_to :vertical
  has_many :courses, dependent: :destroy
end
