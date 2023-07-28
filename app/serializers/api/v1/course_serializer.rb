class Api::V1::CourseSerializer
  include JSONAPI::Serializer

  belongs_to :category, serializer: Api::V1::CategorySerializer

  attributes :id, :name, :state, :author, :created_at, :updated_at
end
