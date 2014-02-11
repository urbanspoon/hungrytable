module Hungrytable
  class RestaurantSearch
    include RequestExtensions
    include ResponseAccessors

    def initialize params
      @params = params
      ensure_required_params
      @requester = GetRequest
    end

    def timeslots
      response['Timeslots']
    end

    private
    def params
      dt = @params[:date_time]
      dt = encode_date_time(dt) if dt.respond_to?(:strftime)
      {
        rid: @params[:restaurant_id],
        dt: dt,
        ps: @params[:party_size]
      }
    end

    def required_params
      %w(restaurant_id date_time party_size).map(&:to_sym)
    end

    def encode_date_time dt
      URI.encode(dt.strftime("%m/%d/%Y %I:%M %p"), /[^a-z0-9\-\.\_\~]/i)
    end

    def request_uri
      "/table/?pid=#{Config.partner_id}&rid=#{params[:rid]}&dt=#{params[:dt]}&ps=#{params[:ps]}"
    end

  end
end
