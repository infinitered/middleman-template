require 'rspec/core/rake_task'
require_relative './helpers/colorizer'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :build do

  desc "Build app from source"
  task :source do
    puts "Building app from source".green
    system "bundle exec middleman build"
    system "chmod -R 755 ./build/assets"
  end

  # Example custom build task
  # task :data do
  #   puts "Building indicators data".green
  #   system "ruby ./build_indicators.rb"
  #   puts "Done".green
  # end
end

desc "Build app from source"
task :build do
  Rake::Task["build:source"].invoke
end

namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}".green
    Rake::Task["build:source"].invoke
    system "app=#{env} bundle exec middleman deploy"
  end

  desc "Deploy to staging"
  task :staging do
    deploy :staging
  end

  desc "Deploy to production"
  task :production do
    deploy :production
  end

  task default: :staging
end

desc "Deploy to staging"
task :deploy do
  Rake::Task["deploy:staging"].invoke
end
