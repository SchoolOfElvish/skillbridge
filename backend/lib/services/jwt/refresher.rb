# frozen_string_literal: true

module Services
  module Jwt
    class Refresher
      include Deps[
        'services.jwt.blacklister',
        'services.jwt.issuer',
        'services.jwt.blacklister',
      ]

      def refresh!(refresh_token:, decoded_token:, user:)
        return Failure(:missing_token, { token: :refresh }) unless refresh_token.present? || decoded_token.nil?

        existing_refresh_token = user.refresh_tokens.search_by_token(refresh_token)

        return Failure(:invalid_token, { token: :refresh }) if existing_refresh_token.blank?

        jti = decoded_token.fetch(:jti)

        new_access_token, new_refresh_token = issuer.call(user)
        existing_refresh_token.destroy!

        blacklister.blacklist!(jti:, exp: decoded_token.fetch(:exp), user:)

        Success([new_access_token, new_refresh_token])
      end
    end
  end
end
