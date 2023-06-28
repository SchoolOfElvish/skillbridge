# frozen_string_literal: true

module Services
  module Users
    class SignIn < Core::Service
      include Deps[
        'services.jwt.issuer',
      ]

      def call(email:, password:)
        @email = email
        @password = password

        user = yield find_user(email)
        yield validate_password(password, user)
        token, refresh_token = yield issue_token(user)
        Success[token, refresh_token]
      end

      private

      attr_reader :email, :password, :user

      def find_user(email)
        user = User.find_by(email:)
        user ? Success(user) : Failure(:user_not_found)
      end

      def validate_password(password, user)
        if user.valid_password?(password)
          Success()
        else
          Failure(:wrong_password)
        end
      end

      def issue_token(user)
        token, refresh_token = yield issuer.call(user)
        Success[token, refresh_token.token]
      end
    end
  end
end
