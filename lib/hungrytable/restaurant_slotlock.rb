module Hungrytable
  class RestaurantSlotlock
    include RequestExtensions

    attr_reader :restaurant_search, :time_slot

    def initialize restaurant_search, requester=PostRequest, time_slot=nil
      @restaurant_search = restaurant_search
      @requester         = requester
      @time_slot         = time_slot
    end

    def successful?
      details["ns:ErrorID"] == "0"
    end

    def errors
      details["ns:ErrorMessage"]
    end

    def slotlock_id
      return nil unless successful?
      details["ns:SlotLockID"]
    end

    def params
      if time_slot.nil? || time_slot == :ideal
        time = restaurant_search.ideal_time
        security_id = restaurant_search.ideal_security_id
      elsif time_slot == :exact
        time = restaurant_search.exact_time
        security_id = restaurant_search.exact_security_ID
      elsif time_slot == :later
        time = restaurant_search.later_time
        security_id = restaurant_search.later_security_ID
      elsif time_slot == :early
        time = restaurant_search.early_time
        security_id = restaurant_search.early_security_ID
      else
        raise "Unrecognized time slot parameter: #{time_slot}"
      end

      {
        'RID'            => restaurant.id,
        'datetime'       => time,
        'partysize'      => restaurant_search.party_size,
        'timesecurityID' => security_id,
        'resultskey'     => restaurant_search.results_key
      }
    end

    private
    def request_uri
      "/slotlock/?pid=#{Config.partner_id}&st=0"
    end

    def restaurant
      restaurant_search.restaurant
    end

    def details
      request.parsed_response["SlotLockResults"]
    end

  end
end
