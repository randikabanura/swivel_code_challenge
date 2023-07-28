
FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    author { Faker::Name.name }
    state { 'active' }
    association :category, factory: :category

    after(:save, &:reindex)
  end
end
