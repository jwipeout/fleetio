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
    let(:update_vehicle_fuel_efficiency) { described_class.perform(vehicle) }

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
        allow(FleetioRuby::FuelEntry).to receive(:filter) do
          { reason_phrase: 'not found', status: '404' }
        end
      end

      it 'does not update vehicle fuel efficiency' do
        update_vehicle_fuel_efficiency

        expect(vehicle.reload.fuel_efficiency).to eq(nil)
      end

      it 'returns no errors' do
        expect(update_vehicle_fuel_efficiency.errors).to eq(
          { reason_phrase: 'not found', status: '404' }.to_s
        )
      end
    end

    context 'when no fuel entries found' do
      before do
        allow(FleetioRuby::FuelEntry).to receive(:filter) { [] }
      end

      it 'does not update vehicle fuel efficiency' do
        update_vehicle_fuel_efficiency

        expect(vehicle.reload.fuel_efficiency).to eq(nil)
      end

      it 'returns no fuel entries error' do
        expect(update_vehicle_fuel_efficiency.errors).to eq(
          I18n.t(:no_matching_fuel_entries, scope: [:errors, :fleetio])
        )
      end
    end

    context 'when vehicle update is not valid' do
      before do
        vehicle.vin = nil
        allow(FleetioRuby::FuelEntry).to receive(:filter) { [vehicle] }
      end

      it 'does not update vehicle fuel efficiency' do
        update_vehicle_fuel_efficiency

        expect(vehicle.reload.fuel_efficiency).to eq(nil)
      end

      it 'returns no errors' do
        expect(update_vehicle_fuel_efficiency.errors).to eq("Vin can't be blank")
      end
    end
  end
end
