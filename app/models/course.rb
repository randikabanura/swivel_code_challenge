class Course < ApplicationRecord
  include ValidationConcern

  belongs_to :category
end
