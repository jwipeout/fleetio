module FleetioRuby
  class Vehicle
    def self.retrieve(**query)
      response = Faraday.get(
        'https://secure.fleetio.com/api/v1/vehicles',
        query,
        Rails.application.config_for(:fleetio_ruby)
      )

      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        { status: response.status, reason_phrase: response.reason_phrase }
      end
    end
  end
end
