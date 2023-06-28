# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  devise_for :users

  scope :api, defaults: { format: :json } do
    post '/sign-in', to: 'users#sign_in'
    post '/refresh-token', to: 'users#refresh_token'
  end
end
