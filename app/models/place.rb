class Place < ApplicationRecord
  # attr_accessible :title, :address, :latitude, :longitude

  geocoded_by :address
  after_validation :geocode if :address_changed?
end
