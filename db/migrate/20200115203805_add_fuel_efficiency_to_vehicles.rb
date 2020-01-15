class AddFuelEfficiencyToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :fuel_efficiency, :decimal, precision: 6, scale: 2
  end
end
