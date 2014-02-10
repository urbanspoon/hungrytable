module Hungrytable
  class ReservationMake
    include RequestExtensions
    include ResponseAccessors

    attr_reader :opts

    def initialize params, requester = PostRequest
      @opts = params
      @requester = requester
      ensure_required_opts
    end

    def successful?
      error_id == "0"
    end

    def confirmation_number
      return nil unless successful?
      details["ns:ConfirmationNumber"]
    end

    def default_options
      {
        OTannouncementOption: 0,
        RestaurantEmailOption: 0,
        firsttimediner: 0,
        specialinstructions: 'none'
      }
    end

    def params
      default_options.merge(opts)
    end

    private
    def required_opts
      %w(email_address firstname lastname phone RID datetime partysize timesecurityID resultskey slotlockid).map(&:to_sym)
    end

    def request_uri
      "/reservation/?pid=#{Config.partner_id}&st=0"
    end

    def details
      request.parsed_response["MakeResults"]
    end

  end
end
