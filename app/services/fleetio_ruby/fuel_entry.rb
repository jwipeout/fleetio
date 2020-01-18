module FleetioRuby
  class FuelEntry
    def self.filter(query = {}, request = Request)
      request.filter(
        'https://secure.fleetio.com/api/v1/fuel_entries',
        **query
      )
    end
  end
end
