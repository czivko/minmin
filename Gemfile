source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=minmin

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :development do
  gem 'quiet_assets'
  gem 'rails_best_practices'
  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'thin'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end

gem 'unicorn'
gem 'pg'
gem 'haml'
gem 'font-awesome-rails'
gem 'nokogiri'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
