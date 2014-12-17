require_relative './helpers/colorizer.rb'

activate :automatic_image_sizes

# Assets Directory Setup
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"

configure :development do
  Slim::Engine.default_options[:pretty] = true
  activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :directory_indexes # Pretty URLs
  activate :asset_hash # Enable cache buster
  activate :imageoptim do |options|
    options.pngout_options = false
    options.advpng_options = false
  end
  activate :gzip

  # Change to your Google Analytics key (e.g. UA-XXXXX-Y)
  # To disable GA, leave unset or set to nil
  set :ga_key, nil

  after_build do
    `chmod -R 755 ./build/assets`
  end
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.build_before = false # Use rake task

  deploy.clean  = true
  if ENV['app'] == "staging"
    deploy.host   = "some_staging.clearsight.webfactional.com"
    deploy.user   = "clearsight"
    deploy.path   = "~/webapps/some_staging"
  else
    abort "Not set up.".red
    deploy.host   = "something.webfactional.com"
    deploy.user   = "something"
    deploy.path   = "~/webapps/something"
  end
end
