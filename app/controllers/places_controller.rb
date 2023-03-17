class PlacesController < ApplicationController
  before_action :set_place, only: %i[ show edit update destroy ]

  # GET /places or /places.json
  def index
    @places = Place.all
  end

  # GET /places/1 or /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places or /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        forecast, cache_hit = check_cache_call_services
        # QueryForecastServicesJob.perform_later(@place.id)
        format.html { redirect_to place_forecast_path(forecast.place_id, forecast.id, cache_hit: cache_hit), notice: "Location found." }
        # format.html { redirect_to place_url(@place), notice: "Place was successfully created." }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1 or /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to place_url(@place), notice: "Place was successfully updated." }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1 or /places/1.json
  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url, notice: "Place was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def check_cache_call_services
      #set cache key and check if it already exist
      cache_key = "#{@place.zipcode}"
      cache_hit = Rails.cache.exist?(cache_key)
      forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        open_weather = OpenWeatherAPI.new(@place.latitude, @place.longitude).call
        gov_weather = WeatherDotGovAPI.new(@place.latitude, @place.longitude).call
        Forecast.create(high_temp: open_weather&.high_temp,
                        low_temp: open_weather&.low_temp,
                        current_temp: open_weather&.temp,
                        icon: open_weather&.icon,
                        place_id: @place&.id,
                        zipcode: @place&.zipcode,
                        details: gov_weather&.details,
                        wind_direction: gov_weather&.wind_direction,
                        wind_speed: gov_weather&.wind_speed
                        )
      end
      return forecast, cache_hit
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:name, :zipcode, :latitude, :longitude, :address)
    end
end
