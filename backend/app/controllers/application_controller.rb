# frozen_string_literal: true

class ApplicationController < ActionController::Base
  delegate :resolve, to: :container

  def container
    Container
  end
end
