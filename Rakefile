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

namespace :setup do
  desc "Update Front-End Frameworks"
  task :update do
    puts 'Updating Bourbon and Neat'.cyan
    system 'cd ./source/assets/stylesheets/_helpers && bourbon update && neat update'
    puts 'Done.'.green
  end

  desc "Install ruby dependencies"
  task :install_gems do
    puts 'Installing ruby dependencies...'.cyan
    system 'bundle'
    puts 'Done.'.green
  end

  desc "Install image optimization libraries"
  task :install_binaries do
    puts 'Installing binary dependencies...'.cyan
    system 'brew install pngcrush optipng'
    puts 'Done.'.green
  end

  desc "Run initial build"
  task :build do
    puts 'Doing initial Middleman build...'.cyan
    system 'bundle exec rake build:source'
    puts 'Done.'.green
  end

  desc "Run entire setup"
  task :setup do
    Rake::Task["setup:install_binaries"].invoke 1
    Rake::Task["setup:install_gems"].invoke 2
    Rake::Task["setup:update"].invoke 3
    Rake::Task["setup:build"].invoke 4

    msg = 'Installation complete. Available commands:'
    puts ('=' * msg.length).cyan
    puts msg.green
    puts ' middleman'.magenta + ' (start server)'.white
    puts ' rake build:source'.magenta
    puts ' rake build:data'.magenta
    puts ' rake deploy:staging'.magenta
    puts ' rake deploy:production'.magenta
    puts
    puts 'Look in the Rakefile for more info.'
  end
end

desc "Sets up your system to run middleman. Does some updates."
task :setup do
  Rake::Task["setup:setup"].invoke
end