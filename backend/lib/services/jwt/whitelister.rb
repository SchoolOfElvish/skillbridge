# frozen_string_literal: true

module Services
  module Jwt
    class Whitelister
      include Deps[
        'persistence.whitelisted_token'
      ]

      def whitelist!(jti:, exp:, user:)
        user.whitelisted_tokens.create!(
          jti:,
          exp: Time.zone.at(exp)
        )
      end

      def remove_whitelist!(jti:)
        whitelist = whitelisted_token.find_by(
          jti:
        )
        whitelist.destroy if whitelist.present?
      end

      def whitelisted?(jti:)
        whitelisted_token.exists?(jti:)
      end
    end
  end
end
