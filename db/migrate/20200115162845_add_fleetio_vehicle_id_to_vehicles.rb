class AddFleetioVehicleIdToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :fleetio_vehicle_id, :integer, null: false
  end
end
