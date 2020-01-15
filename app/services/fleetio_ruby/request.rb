module FleetioRuby
  class Request
    def self.retrieve(url, **query)
      response = Faraday.get(
        url,
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
