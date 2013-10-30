activate :automatic_image_sizes

# Assets Directory Setup
set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"

configure :development do
  Slim::Engine.default_options[:pretty] = true
  activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :directory_indexes # Pretty URLs
  activate :asset_hash # Enable cache buster
  activate :image_optim
  activate :gzip

  # Change to your Google Analytics key (e.g. UA-XXXXX-Y)
  # To disable GA, leave unset or set to nil
  set :ga_key, nil
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = "appname.clearsight.webfactional.com"
  deploy.clean  = true
  deploy.user   = "clearsight"
  deploy.path   = "~/webapps/appname"

  deploy.build_before = true
end
