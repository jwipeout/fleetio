class Vehicle < ApplicationRecord
  validates :vin, presence: true
  validates :vin, uniqueness: true
end
