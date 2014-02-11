module Hungrytable
  class RestaurantSlotlock
    include RequestExtensions
    include ResponseAccessors

    def initialize params
      @params = params
      ensure_required_params
      @requester = PostRequest
    end

    def slotlock_id
      response['SlotLockID']
    end

    private
    def params
      {
        RID:            @params[:restaurant_id],
        datetime:       @params[:date_time],
        partysize:      @params[:party_size],
        timesecurityID: @params[:time_security_id],
        resultskey:     @params[:results_key]
      }
    end

    def required_params
      %w(restaurant_id date_time party_size time_security_id results_key).map(&:to_sym)
    end

    def request_uri
      "/slotlock/?pid=#{Config.partner_id}&st=0"
    end

  end
end
