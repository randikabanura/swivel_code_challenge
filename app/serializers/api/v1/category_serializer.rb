class Api::V1::CategorySerializer
  include JSONAPI::Serializer

  has_many :courses, serializer: Api::V1::CourseSerializer
  belongs_to :vertical, serializer: Api::V1::VerticalSerializer

  attributes :id, :name, :state, :created_at, :updated_at
end
