require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "rescue_registry"

if Mime[:jsonapi].nil?
  Mime::Type.register("application/vnd.api+json", :jsonapi)
end

class GlobalError < StandardError; end
class OtherGlobalError < StandardError; end

module RescueRegistryTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.debug_exception_response_format = :api

    initializer "register_global_exception" do
      ActiveSupport.on_load(:action_controller) do
        register_exception GlobalError, status: 400
      end
    end
  end
end

