# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:access_tokens).class_name('Doorkeeper::AccessToken').with_foreign_key(:resource_owner_id).dependent(:delete_all) }
  end

  describe '.authenticate' do
    it 'returns the user if the email and password are valid' do
      user = FactoryBot.create(:user, email: 'test@example.com', password: 'password')

      authenticated_user = User.authenticate('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil if the email or password is invalid' do
      user = FactoryBot.create(:user, email: 'test@example.com', password: 'password')

      authenticated_user = User.authenticate('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end
  end
end

