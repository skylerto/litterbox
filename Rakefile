require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :rubocop do
  sh 'rubocop spec/package_spec.rb'
end

task default: %i[rubocop spec]
