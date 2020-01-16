module FleetioRuby
  class Vehicle
    def self.filter(query = {})
      Request.filter(
        'https://secure.fleetio.com/api/v1/vehicles',
        **query
      )
    end
  end
end
