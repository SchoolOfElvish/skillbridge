# frozen_string_literal: true

module Services
  module Jwt
    class Decoder < Core::Service
      include Deps['services.jwt.secret', 'jwt']

      def decode!(access_token, verify: true)
        decoded = jwt.decode(access_token, secret.secret, verify, verify_iat: true)[0]

        Failure(:invalid_token) if decoded.blank?

        Success(decoded.symbolize_keys)
      end

      def decode(access_token, verify: true)
        Try[JWT::VerificationError, JWT::DecodeError] { decode!(access_token, verify:) }.to_result
      end
    end
  end
end
