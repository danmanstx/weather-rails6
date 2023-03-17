class CreateForecasts < ActiveRecord::Migration[6.1]
  def change
    create_table :forecasts do |t|
      t.string :current_temp
      t.string :high_temp
      t.string :low_temp
      t.string :zipcode
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
