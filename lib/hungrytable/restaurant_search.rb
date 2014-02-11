module Hungrytable
  class RestaurantSearch
    include RequestExtensions
    include ResponseAccessors

    def initialize params, requester = GetRequest
      @params = params
      @requester = requester
      ensure_required_params
    end

    def timeslots
      response['Timeslots']
    end

    def results_key
      response['ResultsKey']
    end

    private
    def params
      {
        rid: @params[:restaurant_id],
        dt: encode_date_time,
        ps: @params[:party_size]
      }
    end

    def encode_date_time
      URI.encode(@params[:date_time].strftime('%Y-%m-%dT%H:%M:%S'), /[^a-z0-9\-\.\_\~]/i)
    end

    def required_params
      %w(restaurant_id date_time party_size).map(&:to_sym)
    end

    def request_uri
      "/table/?pid=#{Config.partner_id}&rid=#{params[:rid]}&dt=#{params[:dt]}&ps=#{params[:ps]}"
    end

  end
end
