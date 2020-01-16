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
        allow(FleetioRuby::Vehicle).to receive(:retrieve) { [vehicle] }

        post :create, format: :json, params: { vehicle: { vin: '123' } }
      end

      it 'returns status of 201' do
        expect(response.status).to eq(201)
      end
    end

    context 'when vehicle not created' do
      before do
        allow(FleetioRuby::Vehicle).to receive(:retrieve) do
          { reason_phrase: 'not found', status: '404' }
        end

        post :create, format: :json, params: { vehicle: { vin: '123' } }
      end

      it 'returns status of 422' do
        expect(response.status).to eq(422)
      end
    end
  end
end
