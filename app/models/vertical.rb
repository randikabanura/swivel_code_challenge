class Vertical < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  validate :unique_name

  has_many :categories, dependent: :destroy
  has_many :courses, through: :categories

  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true, update_only: true

  def unique_name
    self.errors.add(:name, 'is already taken') if Category.where(name: self.name).exists?
  end

  def search_data
    {
      name: name
    }
  end
end
