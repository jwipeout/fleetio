class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def create
    create_vehicle = VehicleServices::CreateVehicle.perform(vehicle_params[:vin])

    respond_to do |format|
      if create_vehicle.errors.blank?
        format.json { render(json: create_vehicle.vehicle, status: :created) }
      else
        format.json { render(json: create_vehicle.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update_fuel_efficiency
    vehicle = Vehicle.find(params[:id])
    update_vehicle_fuel_efficiency =
      VehicleServices::UpdateVehicleFuelEfficiency.perform(vehicle)

    respond_to do |format|
      if update_vehicle_fuel_efficiency.errors.blank?
        format.json { render(json: update_vehicle_fuel_efficiency.vehicle, status: :ok) }
      else
        format.json do
          render(json: update_vehicle_fuel_efficiency.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:vin)
  end
end
