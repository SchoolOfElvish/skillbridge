# frozen_string_literal: true

module Services
  module Jwt
    class Encoder
      include Deps[
        'secure_random',
        'services.jwt.secret',
        'services.jwt.expiry',
        'jwt',
      ]

      # rubocop:disable Metrics/MethodLength
      def call(user)
        jti = secure_random.hex
        exp = token_expiry
        access_token = jwt.encode(
          {
            user_id: user.id,
            jti:,
            iat: token_issued_at.to_i,
            exp:
          },
          secret.secret
        )

        Success[access_token, jti, exp]
      end
      # rubocop:enable Metrics/MethodLength

      def token_expiry
        (token_issued_at + expiry.expiry).to_i
      end

      def token_issued_at
        Time.zone.now
      end
    end
  end
end
