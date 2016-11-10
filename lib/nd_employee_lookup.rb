require "nd_employee_lookup/engine"
require "jquery-rails"
require "foundation-rails"

module NdEmployeeLookup
  def self.root
    File.expand_path(File.dirname(File.dirname(__FILE__)))
  end

  def self.models_dir
    "#{root}/app/models/nd_employee_lookup"
  end

  def self.controllers_dir
    "#{root}/app/controllers/nd_employee_lookup"
  end
end
