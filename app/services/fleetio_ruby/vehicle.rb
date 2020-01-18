module FleetioRuby
  class Vehicle
    def self.filter(query = {}, request = Request)
      request.filter(
        'https://secure.fleetio.com/api/v1/vehicles',
        **query
      )
    end
  end
end
