class Api::V1::VerticalSerializer
  include JSONAPI::Serializer

  has_many :categories, serializer: Api::V1::CategorySerializer

  attributes :id, :name, :created_at, :updated_at
end
