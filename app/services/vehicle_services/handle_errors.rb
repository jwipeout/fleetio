module VehicleServices
  module HandleErrors
    def request_error?(response_list)
      response_list.is_a?(Hash)
    end

    def no_match?(response_list)
      response_list.empty?
    end

    def result(results = {})
      OpenStruct.new(**results)
    end
  end
end
