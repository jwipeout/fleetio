module VehicleServices
  class CreateVehicle
    class << self
      def perform(vin)
        vehicle_list = FleetioRuby::Vehicle.filter('q[vin_eq]' => vin)

        return result(errors: vehicle_list) if vehicle_list.is_a?(Hash)

        result(
          vehicle: create_vehicle(vehicle_list.first),
          errors: false
        )
      end

      private

      def result(results = {})
        OpenStruct.new(**results)
      end

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
