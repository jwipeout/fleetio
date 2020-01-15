require 'rails_helper'

RSpec.describe FleetioRuby::FuelEntry do
  describe '.retrieve' do
    let(:response) { OpenStruct.new(body: [{ 'vehicle_id' => '1' }].to_json) }

    context 'when vehicle_id found' do
      it 'returns fuel entries that match query' do
        allow(Faraday).to receive(:get) { response }

        result = described_class.retrieve('q[vehicle_id_eq]' => '1')

        expect(result.first['vehicle_id']).to eq('1')
      end
    end

    context 'when vehicle_id not found' do
      it 'returns empty array' do
        response.body = [].to_json

        allow(Faraday).to receive(:get) { response }

        result = described_class.retrieve('q[vehicle_id_eq]' => '12345')

        expect(result.empty?).to eq(true)
      end
    end

    context 'when error parsing body' do
      it 'returns erros' do
        response.body = 'not json'
        response.reason_phrase = 'not found'
        response.status = '404'

        allow(Faraday).to receive(:get) { response }

        result = described_class.retrieve('q[vehicle_id_eq]' => '12345')

        expect(result).to eq(reason_phrase: 'not found', status: '404')
      end
    end
  end
end
