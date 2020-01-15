module FleetioRuby
  class Vehicle
    def self.retrieve(query = {})
      Request.retrieve(
        'https://secure.fleetio.com/api/v1/vehicles',
        **query
      )
    end
  end
end
