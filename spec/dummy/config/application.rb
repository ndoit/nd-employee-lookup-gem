require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
#require "active_record/railtie"
require "action_controller/railtie"
#require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# manage secrets with dotenv
require 'dotenv'
Dotenv.load ".env.local", ".env.#{Rails.env}"

Bundler.require(*Rails.groups)
require "nd_employee_lookup"

module Dummy
  class Application < Rails::Application
  end
end
