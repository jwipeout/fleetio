FactoryBot.define do
  factory :vehicle do
    sequence(:vin) { |n| "T#{n + 1000000000000000}" }
    sequence(:fleetio_vehicle_id) { |n| n }
    year { 2020 }
    make { 'Tesla' }
    model { 'Y' }
  end
end
