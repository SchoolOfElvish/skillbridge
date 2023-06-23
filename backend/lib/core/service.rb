# frozen_string_literal: true

module Core
  # Base operation class. Provides dry-monads do notation and Result monads.
  #
  # @api private
  #
  # @see http://dry-rb.org/gems/dry-monads/1.0/result/ Result monad documentation
  # @see http://dry-rb.org/gems/dry-monads/1.0/do-notation/ Do notation documentation
  #
  # @example
  #
  #   module Services
  #     class Read < Core::Service
  #       def call(payload)
  #         payload = yield Success(payload)
  #         Success(payload)
  #       end
  #     end
  #   end
  #
  #   Services::Read.new.call(a: 1) # => Success(a: 1)
  class Service
    include Dry::Monads[:try, :result, :do]

    def call(*)
      raise NotImplementedError
    end
  end
end
