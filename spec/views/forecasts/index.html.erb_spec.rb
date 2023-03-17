require 'rails_helper'

RSpec.describe 'forecasts/index', type: :view do
  let(:place1) {
    Place.create!(
      name: "MyString",
      latitude: "9.99",
      longitude: "9.99",
      address: "MyString"
    )
  }
  let(:place2) {
    Place.create!(
      name: "MyString",
      latitude: "9.99",
      longitude: "9.99",
      address: "MyString"
    )
  }
  before(:each) do
    assign(:place1, place1)
    assign(:place2, place2)
    assign(:forecasts, [
      Forecast.create!(
        current_temp: 'Current Temp',
        high_temp: 'High Temp',
        low_temp: 'Low Temp',
        zipcode: 'Zipcode',
        place: place1
      ),
      Forecast.create!(
        current_temp: 'Current Temp',
        high_temp: 'High Temp',
        low_temp: 'Low Temp',
        zipcode: 'Zipcode',
        place: place2
      )
    ])
  end
  before(:each) do
    assign(:forecasts, [
      Forecast.create!(
        current_temp: 'Current Temp',
        high_temp: 'High Temp',
        low_temp: 'Low Temp',
        zipcode: 'Zipcode',
        place: Place.create(id: 1)
      ),
      Forecast.create!(
        current_temp: 'Current Temp',
        high_temp: 'High Temp',
        low_temp: 'Low Temp',
        zipcode: 'Zipcode',
        place: Place.create(id: 2)
      )
    ])
  end

  it 'renders a list of forecasts' do
    render
    assert_select 'tr>td', text: 'Current Temp'.to_s, count: 2
    assert_select 'tr>td', text: 'High Temp'.to_s, count: 2
    assert_select 'tr>td', text: 'Low Temp'.to_s, count: 2
    assert_select 'tr>td', text: 'Zipcode'.to_s, count: 2
  end
end
