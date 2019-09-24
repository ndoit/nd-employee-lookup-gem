$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nd_employee_lookup/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nd_employee_lookup"
  s.version     = NdEmployeeLookup::VERSION
  s.authors     = ["Kingdon Barrett"]
  s.email       = ["kbarret8@nd.edu"]
  s.homepage    = "https://bitbucket.com/nd-oit/nd-employee-lookup-gem"
  s.summary     = "Lookup ND employees by name or by NetID"
  s.description = "Rails Engine plugin to enable lookup and cacheing of employee records"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails", "~> 4.2"
  s.add_dependency "jquery-ui-rails", "~> 6.0"
  s.add_dependency "foundation-rails", '~> 5.0'

  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'sinatra'
  s.add_development_dependency 'capybara'
  # s.add_development_dependency 'selenium-webdriver', '~> 2.53.4'
  # s.add_development_dependency 'capybara-webkit', '~> 1.11.1'
  s.add_development_dependency 'database_cleaner'
end
