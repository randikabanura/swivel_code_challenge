class Course < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  enum :state, %i[active inactive]
  validates :state, presence: true, inclusion: { in: states.keys }
  belongs_to :category

  def search_data
    {
      name: name,
      category: category,
      author: author,
      state: state
    }
  end
end
