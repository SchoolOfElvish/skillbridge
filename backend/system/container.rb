# frozen_string_literal: true

require_relative '../lib/core/service'

# Load container and inject dependencies
class Container < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('APP_ENV', 'development').to_sym }
  use :zeitwerk

  configure do |config|
    config.autoloader.enable_reloading
    config.root = Rails.root
    config.component_dirs.add 'lib'
  end

  namespace('persistence') do
    register(:user) { User }
    register(:refresh_token) { RefreshToken }
    register(:blacklisted_token) { BlacklistedToken }
    register(:whitelisted_token) { WhitelistedToken }
  end

  register(:jwt) { JWT }
  register(:secure_random) { SecureRandom }
end

Container.finalize!

Deps = Container.injector
