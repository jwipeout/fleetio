require 'rails_helper'

RSpec.describe VehicleServices::CreateVehicle do
  describe '.perform' do
    let(:vehicle) { attributes_for(:vehicle).merge(id: 1).stringify_keys }
    let(:create_vehicle) { described_class.perform('123') }

    context 'when vehicle found from api' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:filter) { [vehicle] }
      end

      it 'creates vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(1)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq(false)
      end
    end

    context 'when vin is blank' do
      let(:create_vehicle) { described_class.perform(nil) }

      it 'does not create a vehicle' do
        create_vehicle

        expect(Vehicle.count).to eq(0)
      end

      it 'returns no errors' do
        expect(create_vehicle.errors).to eq(
          I18n.t(:no_vin, scope: [:errors, :fleetio])
        )
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
