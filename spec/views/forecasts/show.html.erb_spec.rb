require 'rails_helper'

RSpec.describe 'forecasts/show', type: :view do
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

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Current Temp/)
    expect(rendered).to match(/High Temp/)
    expect(rendered).to match(/Low Temp/)
    expect(rendered).to match(/Zipcode/)
    expect(rendered).to match(//)
  end
end
