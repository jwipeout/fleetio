class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def create
    create_vehicle = VehicleServices::CreateVehicle.perform(vehicle_params[:vin])

    respond_to do |format|
      if !create_vehicle.errors
        format.json { render(json: create_vehicle.vehicle, status: :created) }
      else
        format.json { render(json: create_vehicle.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:vin)
  end
end
