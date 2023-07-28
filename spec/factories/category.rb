
FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    state { 'active' }
    association :vertical, factory: :vertical

    after(:save, &:reindex)
  end
end
