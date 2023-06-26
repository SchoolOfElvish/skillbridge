# frozen_string_literal: true

module Services
  module Jwt
    class Expiry
      def expiry
        2.hours
      end
    end
  end
end
