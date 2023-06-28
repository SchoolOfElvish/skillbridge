# frozen_string_literal: true

module Services
  module Jwt
    class Issuer < Core::Service
      include Deps[
        'services.jwt.encoder',
        'services.jwt.whitelister',
      ]

      def call(user)
        access_token, jti, exp = yield encoder.call(user)
        refresh_token = user.refresh_tokens.create!
        whitelister.whitelist!(
          jti:,
          exp:,
          user:
        )

        Success[access_token, refresh_token]
      end
    end
  end
end
