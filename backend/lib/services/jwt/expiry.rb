# frozen_string_literal: true

module Services
  module Jwt
    class Expiry
      def expiry
        10.seconds
      end
    end
  end
end
