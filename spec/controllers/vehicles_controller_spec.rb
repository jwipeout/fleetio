require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
	let(:vehicles) { create_list(:vehicle, 2) }

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
end
