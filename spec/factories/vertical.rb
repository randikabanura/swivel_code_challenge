
FactoryBot.define do
  factory :vertical do
    name { Faker::Name.name }

    after(:save, &:reindex)
  end
end
