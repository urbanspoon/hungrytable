module Hungrytable
  module RequestExtensions
    extend ActiveSupport::Concern

    attr_reader :params

    def response
      request.parsed_response
    end

    private
    def request
      @request ||= @requester.new(request_uri, params)
    end

    def ensure_required_params
      required_params.each do |key|
        raise ArgumentError, "missing parameter: #{key}" unless @params.has_key?(key)
      end

    end

    # Will be overwritten in objects that send post requests
    def params
      {}
    end
  end
end
