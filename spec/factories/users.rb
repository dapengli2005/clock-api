FactoryBot.define do
  factory :user do
    username { Faker::Lorem.unique.word }
  end
end
