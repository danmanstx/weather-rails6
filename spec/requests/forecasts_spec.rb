require 'rails_helper'

RSpec.describe "/forecasts", type: :request do

  # Forecast. As you add validations to Forecast, be sure to
  # adjust the attributes here as well.
  let(:place) { Place.create(id: 2, name: 'NY NY', address: '123 main st')}
  let(:valid_attributes) { { id: 1, current_temp: '80', high_temp: '95',
    low_temp: '-3', zipcode: '12345', place_id: place.id } }

  let(:invalid_attributes) { { city: "Lou", state: 'KY', country: 'US' } }

  describe "GET /index" do
    it "renders a successful response" do
      Forecast.create! valid_attributes
      get forecasts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      forecast = Forecast.create! valid_attributes
      get place_forecast_url(place, forecast)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_forecast_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      forecast = Forecast.create! valid_attributes
      get edit_place_forecast_url(place,forecast)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Forecast" do
        expect {
          post place_forecasts_url(place), params: { forecast: valid_attributes, }
        }.to change(Forecast, :count).by(1)
      end

      it "redirects to the created forecast" do
        post place_forecasts_url(place), params: { forecast: valid_attributes }
        expect(response).to redirect_to(forecast_url(Forecast.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Forecast" do
        expect {
          post place_forecasts_url(place), params: { forecast: invalid_attributes }
        }.to change(Forecast, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested forecast" do
        forecast = Forecast.create! valid_attributes
        patch forecast_url(forecast), params: { forecast: new_attributes }
        forecast.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the forecast" do
        forecast = Forecast.create! valid_attributes
        patch forecast_url(forecast), params: { forecast: new_attributes }
        forecast.reload
        expect(response).to redirect_to(forecast_url(forecast))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested forecast" do
      forecast = Forecast.create! valid_attributes
      expect {
        delete forecast_url(forecast)
      }.to change(Forecast, :count).by(-1)
    end

    it "redirects to the forecasts list" do
      forecast = Forecast.create! valid_attributes
      delete forecast_url(forecast)
      expect(response).to redirect_to(forecasts_url)
    end
  end
end
