require 'rails_helper'

RSpec.describe "places/show", type: :view do
  before(:each) do
    assign(:place, Place.create!(
      name: "Name",
      latitude: "9.99",
      longitude: "9.99",
      address: "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Address/)
  end
end
