require 'rails_helper'

RSpec.describe 'forecasts/new', type: :view do
  let(:place) {
    Place.create!(
      id: 12312313,
      name: 'MyString',
      latitude: '9.99',
      longitude: '9.99',
      address: 'MyString'
    )
  }
  before(:each) do
    assign(:place, place)
    @forecast = assign(:forecast, Forecast.create!(
      current_temp: 'Current Temp',
      high_temp: 'High Temp',
      low_temp: 'Low Temp',
      zipcode: 'Zipcode',
      place: place
    ))
  end

  it 'renders new forecast form' do
    render
      assert_select 'input[name=?]', 'forecast[current_temp]'
      assert_select 'input[name=?]', 'forecast[high_temp]'
      assert_select 'input[name=?]', 'forecast[low_temp]'
      assert_select 'input[name=?]', 'forecast[zipcode]'
  end
end
