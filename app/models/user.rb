class User < ApplicationRecord
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user.try(:valid_password?, password) ? user : nil
  end
end
