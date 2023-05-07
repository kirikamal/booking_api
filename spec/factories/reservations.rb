# spec/factories/reservations.rb
FactoryBot.define do
  factory :reservation do
    sequence(:reservation_code) { |n| "reservation#{n}" }
    start_date { '2023-05-10' }
    end_date { '2023-05-15' }
    nights { 5 }
    guests { 2 }
    adults { 2 }
    children { 0 }
    infants { 0 }
    status { 'confirmed' }
    currency { 'USD' }
    payout_price { 15000 }
    security_price { 5000 }
    total_price { 20000 }
    association :guest, factory: :guest
  end
end
