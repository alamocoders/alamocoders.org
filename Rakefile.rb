require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task :default => [:spec, :features]

desc "Run all specifications"
RSpec::Core::RakeTask.new() do |t|
end

desc "Run all stories"
Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end
