require 'rails_helper'

RSpec.describe VehicleServices::CreateVehicle do
  describe '.perform' do
    let(:vehicle) { attributes_for(:vehicle).merge(id: 1).stringify_keys }
    let(:create_vehicle) { described_class.perform('123') }

    context 'when vehicle found from api' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:retrieve) { [vehicle] }
      end

      it 'creates vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(1)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq(false)
      end
    end

    context 'when vehicle not found from api' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:retrieve) do
          { reason_phrase: 'not found', status: '404' }
        end
      end

      it 'does not create a vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(0)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq(reason_phrase: 'not found', status: '404')
      end
    end
  end
end
