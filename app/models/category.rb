class Category < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  belongs_to :vertical
  has_many :courses, dependent: :destroy

  def search_data
    {
      name: name,
      vertical: vertical,
      state: state
    }
  end
end
