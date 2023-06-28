# frozen_string_literal: true

module Services
  module Users
    class RefreshToken < Core::Service
      include Deps[
        'services.jwt.refresher',
        'services.jwt.decoder',
      ]

      def call(token_params:)
        @token_params = token_params

        decoded_token = yield decode_token
        user = yield get_user_by(decoded_token[:user_id])
        token, refresh_token = yield refresh_token(decoded_token, user)

        Success[token, refresh_token.token]
      end

      private

      attr_reader :token_params

      def refresh_token(decoded_token, user)
        refresher.call(
          decoded_token:,
          refresh_token: token_params[:refresh_token],
          user:
        )
      end

      def decode_token
        decoder.decode(token_params[:token], verify: false)
      end

      def get_user_by(user_id)
        Success(User.find(user_id))
      rescue StandardError
        Failure(:user_not_found)
      end
    end
  end
end
