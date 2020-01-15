FactoryBot.define do
  factory :vehicle do
    sequence :vin do |n|
      "T#{n + 1000000000000000}"
    end
  end
end
