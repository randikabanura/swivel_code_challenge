class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :name, :created_at, :updated_at
end
