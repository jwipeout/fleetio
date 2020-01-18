module VehicleServices
  class UpdateVehicleFuelEfficiency
    extend HandleErrors

    class << self
      def perform(vehicle)
        fuel_entries_list = FleetioRuby::FuelEntry.filter(
          'q[vehicle_id_eq]' => vehicle.fleetio_vehicle_id
        )

        return result(errors: fuel_entries_list.to_s) if request_error?(fuel_entries_list)

        if no_match?(fuel_entries_list)
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

      def calculate_fuel_efficiency(fuel_entries_list)
        total = fuel_entries_list.inject(Hash.new(0)) do |hash, fe|
          ['usage_in_mi', 'us_gallons'].each do |attribute|
            hash[attribute] += fe[attribute].to_d
          end

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
