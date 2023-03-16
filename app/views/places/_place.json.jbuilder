json.extract! place, :id, :name, :zipcode, :latitude, :longitude, :address, :created_at, :updated_at
json.url place_url(place, format: :json)
