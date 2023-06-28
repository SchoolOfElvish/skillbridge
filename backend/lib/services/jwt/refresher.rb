# frozen_string_literal: true

module Services
  module Jwt
    class Refresher < Core::Service
      include Deps[
        'services.jwt.blacklister',
        'services.jwt.issuer',
      ]

      def call(refresh_token:, decoded_token:, user:)
        return Failure(:missing_token) unless refresh_token.present? || decoded_token.nil?

        existing_refresh_token = RefreshToken.search_by_token(refresh_token)

        return Failure(:invalid_token) if existing_refresh_token.blank?

        jti = decoded_token.fetch(:jti)

        new_access_token, new_refresh_token = yield issuer.call(user)
        existing_refresh_token.destroy!

        blacklister.blacklist!(jti:, exp: decoded_token.fetch(:exp), user:)

        Success[new_access_token, new_refresh_token]
      end
    end
  end
end
