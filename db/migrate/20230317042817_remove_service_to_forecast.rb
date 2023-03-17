class RemoveServiceToForecast < ActiveRecord::Migration[6.1]
  def change
    remove_column :forecasts, :service, :integer, default: 0
  end
end
