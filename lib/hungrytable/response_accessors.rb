module Hungrytable
  module ResponseAccessors
    extend ActiveSupport::Concern

    def error_id
      details["ns:ErrorID"]
    end

    def error_message
      details["ns:ErrorMessage"]
    end

  end
end
