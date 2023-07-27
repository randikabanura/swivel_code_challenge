class Course < ApplicationRecord
  include IndexConcern
  include ValidationConcern

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
