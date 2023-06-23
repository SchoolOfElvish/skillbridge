# frozen_string_literal: true
require_relative '../lib/core/service'

# Load container and inject dependencies
class Container < Dry::System::Container
  configure do |config|
    config.root = Rails.root
    config.component_dirs.add 'lib'
  end
end

Container.finalize!

Deps = Container.injector
