module FleetioRuby
  class FuelEntry
    def self.retrieve(query = {})
      Request.retrieve(
        'https://secure.fleetio.com/api/v1/fuel_entries',
        **query
      )
    end
  end
end
