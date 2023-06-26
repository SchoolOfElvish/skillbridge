# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate!

  delegate :resolve, to: :container

  def container
    Container
  end

  def authenticate!
    current_user, decoded_token = Jwt::Authenticator.call(
      headers: request.headers,
      access_token: params[:access_token]
    )

    @current_user = current_user
    @decoded_token = decoded_token
  rescue JWT::ExpiredSignature
    head :unauthorized
  end
end
