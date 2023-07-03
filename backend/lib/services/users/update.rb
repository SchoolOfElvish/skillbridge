# frozen_string_literal: true

# Service object to update user
# It is used in GraphQL mutation
# @see Mutations::UpdateUser
module Services
  module Users
    class Update < Core::Service
      # @param [User] user - The user to be updated
      # @param [Hash] user_attributes - Provided new user's attributes
      # @return [Dry::Monads::Result]
      #
      # => Success(#<User>) - when user is updated
      # => Failure(:user_cannot_be_saved) - when user is not updated
      def call(user:, attributes:)
        user.assign_attributes(attributes)

        user.save ? Success(user.reload) : Failure(:user_cannot_be_saved)
      end
    end
  end
end
