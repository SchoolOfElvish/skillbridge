# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :updateUser, mutation: Mutations::Users::Update
  end
end
