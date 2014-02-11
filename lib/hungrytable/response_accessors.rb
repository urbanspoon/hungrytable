module Hungrytable
  module ResponseAccessors
    extend ActiveSupport::Concern

    def successful?
      error_id == '0'
    end

    def error_id
      response["ErrorID"]
    end

    def error_message
      response["ErrorMessage"]
    end

  end
end
