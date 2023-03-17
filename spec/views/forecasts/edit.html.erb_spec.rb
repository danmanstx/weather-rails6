require 'rails_helper'

RSpec.describe 'forecasts/edit', type: :view do
  let(:place) {
    Place.create!(
      name: "MyString",
      latitude: "9.99",
      longitude: "9.99",
      address: "MyString"
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

  it 'renders the edit forecast form' do
    render

    assert_select 'form[action=?][method=?]', forecast_path(@forecast), 'post' do

      assert_select 'input[name=?]', 'forecast[current_temp]'
      assert_select 'input[name=?]', 'forecast[high_temp]'
      assert_select 'input[name=?]', 'forecast[low_temp]'
      assert_select 'input[name=?]', 'forecast[zipcode]'
      assert_select 'input[name=?]', 'forecast[place_id]'
    end
  end
end
