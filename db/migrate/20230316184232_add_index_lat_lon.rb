class AddIndexLatLon < ActiveRecord::Migration[6.1]
  def change
    add_index :places, [:latitude, :longitude]
  end
end
