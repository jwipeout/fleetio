module VehicleServices
  class CreateVehicle
    extend HandleErrors

    class << self
      def perform(vin)
        vehicle_list = FleetioRuby::Vehicle.filter('q[vin_eq]' => vin)

        return result(errors: vehicle_list.to_s) if request_error?(vehicle_list)

        if no_match?(vehicle_list)
          return result(
            errors: I18n.t(
              :no_matching_vehicle,
              scope: [:errors, :fleetio]
            )
          )
        end

        new_vehicle = create_vehicle(vehicle_list.first)

        unless new_vehicle.valid?
          return result(errors: new_vehicle.errors.full_messages.join('. '))
        end

        result(
          vehicle: new_vehicle,
          errors: false
        )
      end

      private

      def create_vehicle(vehicle)
        Vehicle.create(
          vin: vehicle['vin'],
          year: vehicle['year'],
          make: vehicle['make'],
          model: vehicle['model'],
          fleetio_vehicle_id: vehicle['id']
        )
      end
    end
  end
end
