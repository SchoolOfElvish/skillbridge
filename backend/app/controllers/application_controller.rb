# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def container
    Container
  end

  def resolve
    container.injector
  end
end
