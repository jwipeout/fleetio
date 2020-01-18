module VehicleServices
  class UpdateVehicleFuelEfficiency
    class << self
      def perform(vehicle_id)
        vehicle = Vehicle.find(vehicle_id)
        fuel_entries_list = FleetioRuby::FuelEntry.filter(
          'q[vehicle_id_eq]' => vehicle.fleetio_vehicle_id
        )

        return result(errors: fuel_entries_list.to_s) if request_error?(fuel_entries_list)

        if no_fuel_entries_match?(fuel_entries_list)
          return result(
            errors: I18n.t(
              :no_matching_fuel_entries,
              scope: [:errors, :fleetio]
            )
          )
        end

        update_vehicle_fuel_efficiency(vehicle, fuel_entries_list)

        unless vehicle.valid?
          return result(errors: vehicle.errors.full_messages.join('. '))
        end

        result(
          vehicle: vehicle,
          errors: false
        )
      end

      private

      def request_error?(fuel_entries_list)
        fuel_entries_list.is_a?(Hash)
      end

      def no_fuel_entries_match?(fuel_entries_list)
        fuel_entries_list.empty?
      end

      def result(results = {})
        OpenStruct.new(**results)
      end

      def calculate_fuel_efficiency(fuel_entries_list)
        total = fuel_entries_list.inject(Hash.new(0)) do |hash, fe|
          hash['usage_in_mi'] += fe['usage_in_mi'].to_d
          hash['us_gallons'] += fe['us_gallons'].to_d
          hash
        end

        total.values.inject(&:/)
      end

      def update_vehicle_fuel_efficiency(vehicle, fuel_entries_list)
        vehicle.update(fuel_efficiency: calculate_fuel_efficiency(fuel_entries_list))
      end
    end
  end
end

