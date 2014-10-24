require 'rspec/core/rake_task'
require 'term-colorizer'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :build do
  task :source do
    puts "Building app from source".green
    system "bundle exec middleman build"
  end
end

task :build do
  Rake::Task["build:source"].invoke
end

namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}".green
    system "app=#{env} bundle exec middleman deploy"
  end

  task :staging do
    deploy :staging
  end

  task :production do
    deploy :production
  end

  task default: :staging
end

task :deploy do
  Rake::Task["deploy:staging"].invoke
end
