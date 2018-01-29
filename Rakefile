require "bundler/gem_tasks"
require "rubocop/rake_task"
require 'cucumber/rake/task'

RuboCop::RakeTask.new

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :default do
  if ENV["RUBOCOP"]
    Rake::Task["rubocop"].invoke
  else
    Rake::Task["features"].invoke
  end
end
