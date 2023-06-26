# frozen_string_literal: true

module Services
  module Jwt
    class Secret
      def secret
        ENV.fetch('JWT_SECRET') { Rails.application.secrets.secret_key_base }
      end
    end
  end
end
