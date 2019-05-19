FactoryBot.define do
  factory :clock_entry, class: 'ClockEntry' do
    action_type { %w(IN OUT).sample }
    datetime { DateTime.now }
    note { Faker::Lorem.word }
    user_id { nil }
  end
end
