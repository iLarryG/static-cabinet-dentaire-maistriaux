###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

# Auto-prefixing of CSS code with vendor prefix
activate :autoprefixer

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
page "/sitemap.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }
activate :protect_emails

###
# Google Analytics
###
activate :google_analytics do |ga|
    ga.tracking_id = data.settings.google_analytics.tracking_code
    ga.anonymize_ip = false
    ga.debug = false
    # ga.development = false
    ga.minify = true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
 configure :development do
   activate :livereload
 end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Directory indexes
# activate :directory_indexes

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do

   #Favicon
   activate :favicon_maker do |f|
    f.template_dir  = File.join(root, 'source')
    f.output_dir    = File.join(root, 'build')
    f.icons = {
      "_favicon_template.png" => [
        { icon: "apple-touch-icon-152x152-precomposed.png" },
        { icon: "apple-touch-icon-144x144-precomposed.png" },
        { icon: "apple-touch-icon-120x120-precomposed.png" },
        { icon: "apple-touch-icon-114x114-precomposed.png" },
        { icon: "apple-touch-icon-76x76-precomposed.png" },
        { icon: "apple-touch-icon-72x72-precomposed.png" },
        { icon: "apple-touch-icon-60x60-precomposed.png" },
        { icon: "apple-touch-icon-57x57-precomposed.png" },
        { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
        { icon: "apple-touch-icon.png", size: "57x57" },
        { icon: "favicon-196x196.png" },
        { icon: "favicon-160x160.png" },
        { icon: "favicon-96x96.png" },
        { icon: "favicon-32x32.png" },
        { icon: "favicon-16x16.png" },
        { icon: "favicon.png", size: "16x16" },
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
        { icon: "mstile-144x144", format: "png" },
      ]
    }
  end

  # Sitemap
  activate :sitemap, hostname: data.settings.site.url

  # Robots.txt
  activate :robots, :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => "http://www.dentistes-dalhem.be/sitemap.xml"

  # Images compression
  activate :imageoptim

  # Minification
  activate :minify_html, remove_input_attributes: false

  # Gzip compression
  activate :gzip

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  #
  require_relative "./lib/build_cleaner"
  activate :build_cleaner
end

# Deployment => to Deploy rake deploy:staging or PASSWORD=gr8passwd rake deploy:production
password = ENV["PASSWORD"]
case ENV['TARGET'].to_s.downcase
when 'production'
  activate :deploy do |deploy|
    deploy.method          = :ftp
    deploy.host            = 'ftp.cluster021.hosting.ovh.net'
    deploy.path            = 'www'
    deploy.user            = 'dentisteww'
    deploy.password        = password
    deploy.build_before = true
  end
else
  activate :deploy do |deploy|
    deploy.method = :git
    deploy.build_before = true
  end

  # Optional Settings
  # deploy.remote = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message' # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
