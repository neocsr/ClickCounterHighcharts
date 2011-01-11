# Tutorial: http://gembundler.com/rails23.html
# source "http://rubygems.org"
source :gemcutter

# bundler requires these gems in all environments
# gem "nokogiri", "1.4.2"
# gem "geokit"
# gem "paperclip", "2.3.8"  
# gem "uploadify", "0.5.0"
# gem "formtastic", "1.2.2"          
# gem "will_paginate", "2.3.15"

gem "rails", "2.3.8"
gem "mongrel", "1.1.5"
gem "sqlite3-ruby", "1.3.2", :require => "sqlite3"
gem "nifty-generators", "0.4.2"  
#gem "haml", "3.0.24"
#gem "devise", "1.0.9"  
#gem "breadcrumbs_on_rails", "1.0.1"

group :development do
  # bundler requires these gems in development
  gem "rails-footnotes", "3.6.7"
end

group :test do
  # bundler requires these gems while running tests
  # gem "rspec"
  gem "faker"    
  gem "populator"    
  #gem "ZenTest", "4.4.0"
  #gem "redgreen", "1.2.2"   
  #gem "autotest-rails", "4.1.0"   
  #gem "memory_test_fix", "0.1.3"
  #gem "mocha", "0.9.10"
end
                          
## Commands

# bundle install --without test development        
# bundle update rails                   
# bundle update                
# bundle package
# bundle install --deployment


## Create config/initializer.rb

# begin
#   require "rubygems"
#   require "bundler"
# rescue LoadError
#   raise "Could not load the bundler gem. Install it with `gem install bundler`."
# end
# 
# if Gem::Version.new(Bundler::VERSION) <= Gem::Version.new("0.9.24")
#   raise RuntimeError, "Your bundler version is too old for Rails 2.3." +
#    "Run `gem install bundler` to upgrade."
# end
# 
# begin
#   # Set up load paths for all bundled gems
#   ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
#   Bundler.setup
# rescue Bundler::GemNotFound
#   raise RuntimeError, "Bundler couldn't find some gems." +
#     "Did you run `bundle install`?"
# end

## Edit config/boot.rb, right above the line `Rails.boot!` 

# class Rails::Boot
#   def run
#     load_initializer
# 
#     Rails::Initializer.class_eval do
#       def load_gems
#         @bundler_loaded ||= Bundler.require :default, Rails.env
#       end
#     end
# 
#     Rails::Initializer.run(:set_load_path)
#   end
# end
