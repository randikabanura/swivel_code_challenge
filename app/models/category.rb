class Category < ApplicationRecord
  include IndexConcern
  include ValidationConcern

  validate :unique_name

  belongs_to :vertical
  has_many :courses, dependent: :destroy

  accepts_nested_attributes_for :courses, reject_if: :all_blank, allow_destroy: true

  def unique_name
    self.errors.add(:name, 'is already taken') if Vertical.where(name: self.name).exists?
  end

  def search_data
    {
      name: name,
      vertical: vertical,
      state: state
    }
  end
end
