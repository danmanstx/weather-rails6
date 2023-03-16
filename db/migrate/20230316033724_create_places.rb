class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :address

      t.timestamps

      add_index :places, [:latitude, :longitude]
    end
  end
end
