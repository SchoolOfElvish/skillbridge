# frozen_string_literal: true

module Services
  module Jwt
    class Issuer
      include Deps[
        'services.jwt.encoder',
        'services.jwt.whitelister',
      ]

      def call(user)
        access_token, jti, exp = encoder.call(user)
        refresh_token = user.refresh_tokens.create!
        whitelister.whitelist!(
          jti:,
          exp:,
          user:
        )

        [access_token, refresh_token]
      end
    end
  end
end
