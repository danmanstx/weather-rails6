json.extract! forecast, :id, :current_temp, :high_temp, :low_temp, :zipcode, :place_id, :created_at, :updated_at
json.url forecast_url(forecast, format: :json)
