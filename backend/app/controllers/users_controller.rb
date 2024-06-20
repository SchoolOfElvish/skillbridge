# frozen_string_literal: true

class UsersController < ApplicationController
  include Dry::Monads::Result::Mixin

  def sign_in
    case login_user(params)
    in Success[token, refresh_token]
      render json: { token:, refreshToken: refresh_token }
    in Failure[:wrong_password]
      render_failure('Wrong password', :unauthorized)
    in Failure[:user_not_found]
      render_failure('User not found', :not_found)
    in Failure[:user_not_confirmed]
      render_failure('User not confirmed', :unauthorized)
    end
  end

  def refresh_token
    case refresh
    in Success[token, refresh_token]
      render json: { token:, refreshToken: refresh_token }
    in Failure[:invalid_token]
      render_failure('Invalid token', :unauthorized)
    in Failure[:missing_token]
      render_failure('Missing token', :unauthorized)
    in Failure[:user_not_found]
      render_failure('User not found', :not_found)
    end
  end

  private

  def refresh
    Container['services.users.refresh_token'].call(
      token_params: {
        token: params[:token],
        refresh_token: params[:refreshToken]
      }
    )
  end

  def render_failure(text, status = :bad_request)
    render(json: { error: text }, status:)
  end

  def login_user(params)
    Container['services.users.sign_in'].call(email: params[:email], password: params[:password])
  end
end
