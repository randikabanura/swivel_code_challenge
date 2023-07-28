require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:state) }
    it { should define_enum_for(:state).with_values(%i[active inactive]) }

    it 'validates uniqueness of name within Vertical' do
      vertical = FactoryBot.create(:vertical)
      FactoryBot.create(:category, name: 'Test Category', vertical: vertical)

      category = FactoryBot.build(:category, name: 'Test Category', vertical: vertical)
      category.valid?

      expect(category.errors[:name]).to include('has already been taken')
    end

    it 'does not add error if name is unique within Vertical' do
      category = FactoryBot.build(:category, name: 'Test Category')
      category.valid?

      expect(category.errors[:name]).to_not include('is already taken')
    end
  end

  describe 'associations' do
    it { should belong_to(:vertical) }
    it { should have_many(:courses).dependent(:destroy) }

    it { should accept_nested_attributes_for(:courses).allow_destroy(true).update_only(true) }
  end

  describe '#search_data' do
    it 'returns the correct search data hash' do
      vertical = FactoryBot.create(:vertical, name: 'Test Vertical')
      category = FactoryBot.create(:category, name: 'Test Category', vertical: vertical)

      expect(category.search_data).to eq({
                                           name: 'Test Category',
                                           vertical: vertical,
                                           state: 'active'
                                         })
    end
  end
end
