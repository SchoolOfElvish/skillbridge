# frozen_string_literal: true

# # require 'dry/system/container'
# # require 'dry/auto_inject'
#
# class AppContainer < Dry::System::Container
#   configure do |config|
#     config.root = Rails.root
#     config.component_dirs.add 'lib'
#   end
# end
#
# AppContainer.finalize!
# Deps = AppContainer.injector
#
# # AppContainer['services.core.service']
