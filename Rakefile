# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Wido2::Application.load_tasks


begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new("spec:rcov") do |t|
    t.ruby_opts = [ "-rsimplecov" ]
    t.fail_on_error = false
  end
rescue LoadError
  puts ""
end