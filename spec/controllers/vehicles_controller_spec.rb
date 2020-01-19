require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns status of 200' do
      expect(response.status).to eq(200)
    end

    it 'renders template index' do
      expect(response.status).to render_template(:index)
    end
  end

  describe 'POST #create' do
    let(:vehicle) { attributes_for(:vehicle).merge(id: 1).stringify_keys }

    context 'when vehicle created' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:filter) { [vehicle] }

        post :create, format: :json, params: { vehicle: { vin: '123' } }
      end

      it 'returns status of 201' do
        expect(response.status).to eq(201)
      end
    end

    context 'when vehicle not created' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:filter) do
          { reason_phrase: 'not found', status: '404' }
        end

        post :create, format: :json, params: { vehicle: { vin: '123' } }
      end

      it 'returns status of 422' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'POST #update_fuel_efficiency' do
    let(:vehicle) { create(:vehicle) }
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

    context 'when vehicle updated' do
      before do
        allow(FleetioRuby::FuelEntry).to receive(:filter) { fuel_entries }

        post :update_fuel_efficiency, format: :json, params: { id: vehicle.id }
      end

      it 'returns status of 201' do
        expect(response.status).to eq(200)
      end
    end

    context 'when vehicle not updated' do
      before do
        allow(FleetioRuby::FuelEntry).to receive(:filter) do
          { reason_phrase: 'not found', status: '404' }
        end

        post :update_fuel_efficiency, format: :json, params: { id: vehicle.id }
      end

      it 'returns status of 422' do
        expect(response.status).to eq(422)
      end
    end
  end
end
