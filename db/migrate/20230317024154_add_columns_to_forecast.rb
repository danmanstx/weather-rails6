class AddColumnsToForecast < ActiveRecord::Migration[6.1]
  def change
    add_column :forecasts, :details, :string
    add_column :forecasts, :icon, :string
    add_column :forecasts, :feels_like, :string
    add_column :forecasts, :wind_speed, :string
    add_column :forecasts, :wind_direction, :string
  end
end
