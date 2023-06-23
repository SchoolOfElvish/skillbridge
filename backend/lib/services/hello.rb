# frozen_string_literal: true

module Services
  class Hello < Core::Service
    def call(payload)
      payload = yield Success(payload)
      Success(payload)
    end
  end
end
