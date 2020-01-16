require 'rails_helper'

RSpec.describe FleetioRuby::Vehicle do
  describe '.filter' do
    let(:response) { OpenStruct.new(body: [{ 'vin' => '12345' }].to_json) }

    context 'when vin found' do
      it 'returns vehicles that match query' do
        allow(Faraday).to receive(:get) { response }

        result = described_class.filter('q[vin_eq]' => '12345')

        expect(result.first['vin']).to eq('12345')
      end
    end

    context 'when vin not found' do
      it 'returns empty array' do
        response.body = [].to_json

        allow(Faraday).to receive(:get) { response }

        result = described_class.filter('q[vin_eq]' => '12345')

        expect(result.empty?).to eq(true)
      end
    end

    context 'when error parsing body' do
      it 'returns erros' do
        response.body = 'not json'
        response.reason_phrase = 'not found'
        response.status = '404'

        allow(Faraday).to receive(:get) { response }

        result = described_class.filter('q[vin_eq]' => '12345')

        expect(result).to eq(reason_phrase: 'not found', status: '404')
      end
    end
  end
end
