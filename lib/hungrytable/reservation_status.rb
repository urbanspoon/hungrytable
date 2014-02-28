module Hungrytable
  class ReservationStatus
    include RequestExtensions
    include ResponseAccessors

    def initialize params
      @params = params
      ensure_required_params
      @requester = GetRequest
    end

    private

    def params
      {
          rid: @params[:restaurant_id],
          conf: @params[:confirmation_number]
      }
    end

    def required_params
      %w(restaurant_id confirmation_number).map(&:to_sym)
    end

    def request_uri
      "/reservation/?pid=#{Config.partner_id}&rid=#{params[:rid]}&conf=#{params[:conf]}"
    end

  end
end
