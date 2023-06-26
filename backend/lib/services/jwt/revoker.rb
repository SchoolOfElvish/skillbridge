# frozen_string_literal: true

module Services
  module Jwt
    class Revoker
      include Deps[
        'services.jwt.whitelister',
        'services.jwt.blacklister',
      ]

      def revoke(decoded_token:, user:)
        jti = decoded_token.fetch(:jti)
        exp = decoded_token.fetch(:exp)

        whitelister.remove_whitelist!(jti:)
        blacklister.blacklist!(
          jti:,
          exp:,
          user:
        )
      rescue StandardError
        raise Errors::Jwt::InvalidToken
      end
    end
  end
end
