FactoryBot.define do
  factory :guest do
    sequence(:email) { |n| "guest#{n}@example.com" }
    first_name { 'John' }
    last_name { 'Doe' }
    phone { '1234567890' }
  end
end
