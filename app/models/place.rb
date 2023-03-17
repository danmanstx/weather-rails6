class Place < ApplicationRecord
  has_many :forecasts
  geocoded_by :address
  after_validation :geocode if :address_changed?

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.zipcode = geo.postal_code
      obj.city = geo.city
      obj.state = geo.state_code
    end
  end

  after_validation :reverse_geocode if :address_changed?
end
