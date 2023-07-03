# frozen_string_literal: true

module Mutations
  module Users
    class Update < BaseMutation
      field :user, Types::UserType, null: false

      argument :user_id, ID, required: true, loads: Types::UserType

      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :birthdate, GraphQL::Types::ISO8601Date, required: false
      argument :about, String, required: false

      def resolve(user:, **attributes)
        result = Container['services.users.update'].call(user:, attributes:)

        case result
        in Success(user)
          { user: }
        in Failure(:user_cannot_be_saved)
          raise GraphQL::ExecutionError, 'User cannot be saved'
        end
      end
    end
  end
end
