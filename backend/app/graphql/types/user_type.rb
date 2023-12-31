# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    # field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :image_url, String, null: false
    field :birthdate, GraphQL::Types::ISO8601Date, null: true
    field :about, String, null: true

    def image_url
      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'

      # raise GraphQL::ExecutionError, "You don't have permission to access this field"
    end

    def first_name
      'Nick'
    end

    def last_name
      'Pupko'
    end

    def birthdate
      '1998-10-10'
    end

    def about
      "I'm a very nice person"
    end
  end
end
