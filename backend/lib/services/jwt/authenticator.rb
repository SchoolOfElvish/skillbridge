# frozen_string_literal: true

module Services
  module Jwt
    class Authenticator < Core::Service
      include Deps[
        'services.jwt.blacklister',
        'services.jwt.whitelister',
        'services.jwt.decoder',
        user_model: 'persistence.user'
      ]

      def call(headers:, access_token:)
        token = yield receive_token(headers, access_token)
        decoded_token = yield decoder.decode(token)
        user = yield authenticate_user_from_token(decoded_token)

        return Failure(:unauthorized) if user.blank?

        Success[user, decoded_token]
      end

      def receive_token(headers, access_token)
        token = access_token || authenticate_header(headers)
        return Failure(:jwt_token_is_missing) if token.blank?

        Success(token)
      end

      def authenticate_header(headers)
        headers['Authorization']&.split('Bearer ')&.last
      end

      def authenticate_user_from_token(decoded_token)
        return Failure(:invalid_token) unless decoded_token[:jti].present? && decoded_token[:user_id].present?

        user = user_model.find(decoded_token.fetch(:user_id))
        blacklisted = blacklisted?(decoded_token)
        whitelisted = whitelisted?(decoded_token)
        valid_issued_at = valid_issued_at?(user, decoded_token)

        return Success(user) if !blacklisted && whitelisted && valid_issued_at

        Failure(:invalid_token)
      end

      def blacklisted?(decoded_token)
        blacklister.blacklisted?(jti: decoded_token[:jti])
      end

      def whitelisted?(decoded_token)
        whitelister.whitelisted?(jti: decoded_token[:jti])
      end

      def valid_issued_at?(user, decoded_token)
        !user.token_issued_at || decoded_token[:iat] >= user.token_issued_at.to_i
      end
    end
  end
end
