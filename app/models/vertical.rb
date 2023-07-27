class Vertical < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  has_many :categories, dependent: :destroy
  has_many :courses, through: :categories

  def search_data
    {
      name: name
    }
  end
end
