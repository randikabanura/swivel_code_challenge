require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:state) }
    it { should define_enum_for(:state).with_values(%i[active inactive]) }

    it 'validates uniqueness of name within Vertical' do
      category = FactoryBot.create(:category)
      FactoryBot.create(:course, name: 'Test Course', category: category)

      course = FactoryBot.build(:course, name: 'Test Course', category: category)
      course.valid?

      expect(course.errors[:name]).to include('has already been taken')
    end

    it 'does not add error if name is unique within Vertical' do
      course = FactoryBot.build(:course, name: 'Test Course')
      course.valid?

      expect(course.errors[:name]).to_not include('is already taken')
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }
  end

  describe '#search_data' do
    it 'returns the correct search data hash' do
      category = FactoryBot.create(:category, name: 'Test Category')
      course = FactoryBot.create(:course, name: 'Test Course', category: category)

      expect(course.search_data).to eq({
                                           name: 'Test Course',
                                           category: category,
                                           author: course.author,
                                           state: 'active'
                                         })
    end
  end
end
