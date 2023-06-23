# frozen_string_literal: true

module Services
  class Another < Core::Service
    include Deps['services.hello']

    def call(payload)
      hello.call(payload)
    end
  end
end
