require 'rails_helper'
Geocoder.configure(lookup: :test, ip_lookup: :test)
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'coordinates'  => [40.7143528, -74.0059731],
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US',
      'postal_code'  => '55555'
    }
  ]
)

RSpec.describe Place, type: :model do
  context "Place create call should set values from geocoder" do
    let(:place) { Place.create(address: 'New York, NY, USA') }

    it 'should set other values based on geocoder' do
      expect(place.state).to eq('NY')
      expect(place.longitude).to eq(-74.0059731)
      expect(place.latitude).to eq(40.7143528)
      expect(place.zipcode).to eq('55555')
    end
  end
end
