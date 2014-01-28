source 'https://rubygems.org'
source "https://rails-assets.org"

gem 'rails', '~> 4.0.2'
gem 'pg', '~> 0.17'
gem 'rails-i18n', '~> 4.0.0'


# model
gem 'acts-as-taggable-on', '~> 2.4.1'
gem 'devise', '~> 3.0.0.rc'
gem 'devise-i18n', '~> 0.8.5'
gem "omniauth-google-oauth2", "~> 0.2.1"
gem "fume-settable", "~> 0.0.2"
gem "carrierwave", "~> 0.9.0"
gem "kaminari", "~> 0.14.1"
gem "symbolize", "~> 4.4.1"


# view
gem 'simple_form', '~> 3.0.0'
gem 'rack-cors', '~> 0.2.8'
gem 'kramdown', '~> 1.2.0'
gem 'nokogiri', '~> 1.6.0'
gem 'pygments.rb', '~> 0.5.4'


# rails-assets
gem "rails-assets-jquery"
gem "rails-assets-bootstrap"
gem "rails-assets-eonasdan-bootstrap-datetimepicker", "~> 2.1.30"
gem "rails-assets-bootstrap-tagsinput", "~> 0.3.9"

# assets
gem 'jquery-rails', '~> 3.0.1'   # override rails-assets-jquery
gem 'bootstrap-sass', '~> 3.0.2' # override rails-assets-bootstrap
gem 'font-awesome-rails', '~> 4.0.3'

# assets tools
gem 'compass-rails', "~> 1.1.3"
gem 'sass-rails', '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.1'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier', '>= 1.3.0'


# helper
gem "bugsnag", "~> 1.7.0"


group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'fume-dev'
  gem 'guard-annotate'

  gem 'binding_of_caller'
  gem 'better_errors'

  # gem 'letter_opener'
  # gem 'timecop', '~> 0.7.0'
  
  gem 'factory_girl_rails', '~> 4.3.0'
  gem "rspec-rails", "~> 2.14.1"
end

group :test do
  gem 'shoulda-matchers', '~> 2.5.0'
  gem 'simplecov', require: false
end