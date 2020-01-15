class Vehicle < ApplicationRecord
  validates :vin, presence: true
  validates :vin, uniqueness: true
  validates :fleetio_vehicle_id, presence: true
  validates :fleetio_vehicle_id, uniqueness: true
end
