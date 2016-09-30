module NdEmployeeLookup
  class Engine < ::Rails::Engine
    config.assets.paths << File.expand_path("../../assets/stylesheets", __FILE__)
    config.assets.paths << File.expand_path("../../assets/javascripts", __FILE__)
    config.assets.precompile += %w( employee_lookup.js employee_lookup.css )
    config.autoload_paths += %W(#{config.root}/lib)
    isolate_namespace NdEmployeeLookup
  end
end
