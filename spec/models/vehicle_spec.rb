require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:vin) }

    it 'validates uniqueness of vin' do
      create(:vehicle)
      is_expected.to validate_uniqueness_of(:vin)
    end

    it { is_expected.to validate_presence_of(:fleetio_vehicle_id) }

    it 'validates uniqueness of fleetio_vehicle_id' do
      create(:vehicle)
      is_expected.to validate_uniqueness_of(:fleetio_vehicle_id)
    end
  end
end
