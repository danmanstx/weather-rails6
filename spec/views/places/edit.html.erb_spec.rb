require 'rails_helper'

RSpec.describe "places/edit", type: :view do
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
  end

  it "renders the edit place form" do
    render

    assert_select "form[action=?][method=?]", place_path(place), "post" do

      assert_select "input[name=?]", "place[name]"

      assert_select "input[name=?]", "place[latitude]"

      assert_select "input[name=?]", "place[longitude]"

      assert_select "input[name=?]", "place[address]"
    end
  end
end
