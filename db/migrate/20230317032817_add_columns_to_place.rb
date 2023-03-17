class AddColumnsToPlace < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :state, :string
    add_column :places, :city, :string
  end
end
