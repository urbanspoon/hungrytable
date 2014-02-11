module Hungrytable
  class ReservationCancel
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
        conf: @params[:confirmation_number],
        email: @params[:email]
      }
    end

    def required_params
      %w(restaurant_id confirmation_number email).map(&:to_sym)
    end

    def request_uri
      "/reservation/?pid=#{Config.partner_id}&rid=#{params[:rid]}&conf=#{params[:conf]}&email=#{CGI.escape(params[:email])}"
    end

  end
end
