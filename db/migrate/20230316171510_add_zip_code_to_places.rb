class AddZipCodeToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :zipcode, :string
  end
end
