# frozen_string_literal: true

module Services
  module Jwt
    class Blacklister
      include Deps['persistence.blacklisted_token']

      def blacklist!(jti:, exp:, user:)
        user.blacklisted_tokens.create!(
          jti:,
          exp: Time.zone.at(exp)
        )
      end

      def blacklisted?(jti:)
        blacklisted_token.exists?(jti:)
      end
    end
  end
end
