require 'httparty'

class OpenWeatherAPI
  include HTTParty
  base_uri 'api.openweathermap.org'

  def initialize(latitude, longitude, units = 'imperial')
    @options = { query: { lat: latitude, lon: longitude, units: units, appid: api_key } }
  end

  def call
    weather
  end

  def weather
    res =  self.class.get("/data/2.5/weather", @options)
    return nil if res == nil
    weather = OpenStruct.new
    weather.temp = res['main']['temp']
    weather.feels_like = res['main']['feels_like']
    weather.high_temp = res['main']['temp_max']
    weather.low_temp = res['main']['temp_min']
    weather.icon = res['weather'][0]['icon']
    weather
  # rescue
    # return { status: 500, error: "error with OpenWeatherAPI" }
  end

  private
    def api_key
      ENV.fetch('OPEN_WEATHER_API')
    end
end

# {"coord"=>{"lon"=>-122.4194, "lat"=>37.774},
#  "weather"=>[{"id"=>801, "main"=>"Clouds", "description"=>"few clouds", "icon"=>"02n"}],
#  "base"=>"stations",
#  "main"=>{"temp"=>53.04, "feels_like"=>51.53, "temp_min"=>49.71, "temp_max"=>58.87, "pressure"=>1016, "humidity"=>74},
#  "visibility"=>10000,
#  "wind"=>{"speed"=>19.57, "deg"=>280},
#  "clouds"=>{"all"=>20},
#  "dt"=>1679020011,
#  "sys"=>{"type"=>2, "id"=>2003880, "country"=>"US", "sunrise"=>1678976372, "sunset"=>1679019433},
#  "timezone"=>-25200,
#  "id"=>5391959,
#  "name"=>"San Francisco",
#  "cod"=>200}