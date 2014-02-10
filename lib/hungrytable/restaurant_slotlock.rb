module Hungrytable
  class RestaurantSlotlock
    include RequestExtensions
    include ResponseAccessors

    attr_reader :restaurant_search
    attr_reader :security_id, :time, :results_key, :restaurant_id, :party_size

    def initialize reservation_attributes, requester = PostRequest
      @security_id = reservation_attributes[:security_id]
      @time = reservation_attributes[:time]
      @results_key = reservation_attributes[:results_key]
      @restaurant_id = reservation_attributes[:restaurant_id]
      @party_size = reservation_attributes[:party_size]
      @requester = requester
    end

    def successful?
      error_id == "0"
    end

    def errors
      details["ns:ErrorMessage"]
    end

    def slotlock_id
      return nil unless successful?
      details["ns:SlotLockID"]
    end

    def params
      {
        RID:            restaurant_id,
        datetime:       time,
        partysize:      party_size,
        timesecurityID: security_id,
        resultskey:     results_key
      }
    end

    private
    def request_uri
      "/slotlock/?pid=#{Config.partner_id}&st=0"
    end

    def details
      request.parsed_response["SlotLockResults"] || request.parsed_response["CreditCardSlotLockResults"] # FIXME: should not use CCSlotLockResults
    end

  end
end
