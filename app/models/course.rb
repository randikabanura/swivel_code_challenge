class Course < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  belongs_to :category
end
