require 'rspec/core/rake_task'
require_relative './helpers/colorizer'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :build do
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

task :build do
  Rake::Task["build:source"].invoke
end

namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}".green
    Rake::Task["build:source"].invoke
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
