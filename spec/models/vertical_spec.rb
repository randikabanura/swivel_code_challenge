# spec/models/vertical_spec.rb
require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe 'validations' do
    it 'validates uniqueness of name' do
      FactoryBot.create(:vertical, name: 'Test Vertical')

      vertical = FactoryBot.build(:vertical, name: 'Test Vertical')
      vertical.valid?

      expect(vertical.errors[:name]).to include('has already been taken')
    end

    it 'does not add error if name is unique' do
      vertical = FactoryBot.build(:vertical, name: 'Test Vertical')
      vertical.valid?

      expect(vertical.errors[:name]).to_not include('is already taken')
    end
  end

  describe 'associations' do
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:courses).through(:categories) }

    it { should accept_nested_attributes_for(:categories).allow_destroy(true).update_only(true) }
  end

  describe '#search_data' do
    it 'returns the correct search data hash' do
      vertical = FactoryBot.create(:vertical, name: 'Test Vertical')

      expect(vertical.search_data).to eq({
                                           name: 'Test Vertical'
                                         })
    end
  end
end

