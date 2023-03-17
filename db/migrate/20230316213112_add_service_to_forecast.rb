class AddServiceToForecast < ActiveRecord::Migration[6.1]
  def change
    add_column :forecasts, :service, :integer, default: 0
  end
end
