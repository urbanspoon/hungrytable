module Hungrytable
  class ReservationMake
    include RequestExtensions
    include ResponseAccessors

    def initialize params
      @params = params
      ensure_required_params
      @requester = PostRequest
    end

    def confirmation_number
      response['ConfirmationNumber']
    end

    def message
      response['Message']
    end

    private

    def params
      {
        email_address:          @params[:email],
        RID:                    @params[:restaurant_id],
        datetime:               @params[:date_time],
        partysize:              @params[:party_size],
        phone:                  @params[:phone],
        OTannouncementOption:   @params[:ot_announcement_option] || 0,
        RestaurantEmailOption:  @params[:restaurant_email_option] || 0,
        firstname:              @params[:first_name],
        lastname:               @params[:last_name],
        timesecurityID:         @params[:time_security_id],
        resultskey:             @params[:results_key],
        firsttimediner:         @params[:first_time_diner] || 0,
        specialinstructions:    @params[:special_instructions] || 'none',
        slotlockid:             @params[:slotlock_id]
      }
    end

    def required_params
      %w(email restaurant_id date_time party_size phone first_name last_name time_security_id results_key slotlock_id).map(&:to_sym)
    end

    def request_uri
      "/reservation/?pid=#{Config.partner_id}&st=0"
    end

  end
end
