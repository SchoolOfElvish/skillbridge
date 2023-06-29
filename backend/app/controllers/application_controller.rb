# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  include Deps['services.jwt.authenticator']
  include Dry::Monads::Result::Mixin

  delegate :resolve, to: :container

  def container
    Container
  end

  def authenticate!
    return if introspection_query? && Rails.env.development?

    result = authenticator.call(
      headers: request.headers,
      access_token: params[:access_token]
    )

    case result
    in Success(current_user, decoded_token)
      set_current_user(current_user, decoded_token)
    in Failure(error)
      render json: { errors: [error], data: {} }, status: :unauthorized
    end
  end

  def set_current_user(current_user, decoded_token)
    @current_user = current_user
    @decoded_token = decoded_token
  end

  def introspection_query?
    request.headers['X-Introspection'].present?
  end
end
