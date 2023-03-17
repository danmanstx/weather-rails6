class QueryForecastServicesJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform(place_id)
    place = Place.find(place_id)
    open_weather = OpenWeatherAPI.new(place.longitude,place.latitude).call
    gov_weather = WeatherDotGovAPI.new(place.longitude,place.latitude).call
    Forecast.create(high_temp: open_weather.high_temp,
                    low_temp: open_weather.low_temp,
                    current_temp: open_weather.temp,
                    icon: open_weather.icon,
                    place_id: @place.id,
                    zipcode: @place.zipcode,
                    details: gov_weather.details,
                    wind_direction: gov_weather.wind_direction,
                    wind_speed: gov_weather.wind_speed
                   )
  end
end
