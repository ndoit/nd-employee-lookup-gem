ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'webmock/rspec'
#require 'capybara-webkit'
#require 'capybara/rspec'
#require 'capybara/webkit/matchers'
# require 'database_cleaner'
#Capybara.javascript_driver = :webkit

# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
# Capybara.javascript_driver = :chrome

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  #config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
