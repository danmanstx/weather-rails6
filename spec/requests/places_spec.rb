require 'rails_helper'

RSpec.describe "/places", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Place. As you add validations to Place, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { address: 'New York, NY, USA', state: 'NY', longitude: '4', latitude: '3' }
  }

  let(:invalid_attributes) {
    { current_temp: '80', high_temp: '95', low_temp: '-3' }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Place.create! valid_attributes
      get places_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      place = Place.create! valid_attributes
      get place_url(place)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_place_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      place = Place.create! valid_attributes
      get edit_place_url(place)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Place" do
        expect {
          post places_url, params: { place: valid_attributes }
        }.to change(Place, :count).by(1)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested place" do
        place = Place.create! valid_attributes
        patch place_url(place), params: { place: new_attributes }
        place.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the place" do
        place = Place.create! valid_attributes
        patch place_url(place), params: { place: new_attributes }
        place.reload
        expect(response).to redirect_to(place_url(place))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested place" do
      place = Place.create! valid_attributes
      expect {
        delete place_url(place)
      }.to change(Place, :count).by(-1)
    end

    it "redirects to the places list" do
      place = Place.create! valid_attributes
      delete place_url(place)
      expect(response).to redirect_to(places_url)
    end
  end
end
