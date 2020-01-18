require 'rails_helper'

RSpec.describe VehicleServices::UpdateVehicleFuelEfficiency do
  describe '.perform' do
    let(:fuel_entries) do
      [
        {
          'usage_in_mi' => '500',
          'us_gallons' => '29.34'
        },
        {
          'usage_in_mi' => '250',
          'us_gallons' => '49.34'
        }
      ]
    end
    let(:vehicle) { create(:vehicle) }
    let(:update_vehicle_fuel_efficiency) { described_class.perform(vehicle.id) }

    context 'when vehicle found from api' do
      before do
        vehicle
        allow(FleetioRuby::FuelEntry).to receive(:filter) { fuel_entries }
      end

      it 'updates vehicle fuel_efficiency' do
        update_vehicle_fuel_efficiency

        expect(vehicle.reload.fuel_efficiency.to_f).to eq(9.53)
      end

      it 'returns no errors' do
        expect(update_vehicle_fuel_efficiency.errors).to eq(false)
      end
    end

    context 'when error occurs from request' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:filter) do
          { reason_phrase: 'not found', status: '404' }
        end
      end

      it 'does not create a vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(0)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq({ reason_phrase: 'not found', status: '404' }.to_s)
      end
    end

    context 'when vehicle not found from api' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:filter) { [] }
      end

      it 'does not create a vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(0)
      end

      it 'returns no matching vehicle error' do
        expect(create_vehicle.errors).to eq(
          I18n.t(:no_matching_vehicle, scope: [:errors, :fleetio])
        )
      end
    end

    context 'when vehicle creation is not valid' do
      let(:existing_vehicle) { create(:vehicle, vin: vehicle['vin']) }

      before do
        existing_vehicle
        allow(FleetioRuby::Vehicle).to receive(:filter) { [vehicle] }
      end

      it 'does not create a vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(1)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq('Vin has already been taken')
      end
    end
  end
end
