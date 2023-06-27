# frozen_string_literal: true

# Trigger container reload on reload! command in Rails console
ActiveSupport::Reloader.to_prepare do
  Container.autoloader.reload
end
