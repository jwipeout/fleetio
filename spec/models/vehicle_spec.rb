require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:vin) }

    it 'validates uniqueness of vin' do
      create(:vehicle)
      is_expected.to validate_uniqueness_of(:vin)
    end
  end
end
