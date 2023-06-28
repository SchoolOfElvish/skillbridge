# frozen_string_literal: true

module Services
  module Jwt
    class Secret
      def secret
        ENV.fetch('JWT_SECRET', 'secret')
      end
    end
  end
end
