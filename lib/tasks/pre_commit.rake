namespace :pre_commit do
  desc 'Run rspec pre-commit task'
  task :ci => :spec
end
