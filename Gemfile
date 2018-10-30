source 'https://rubygems.org'

gem 'rails', '4.2.5.1'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'coffee-rails', '~> 4.1.0'
gem 'haml-rails', '~> 0.9'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'pg', '~> 0.15'
gem 'react-rails', '~> 1.6.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# MINA DEPLOYMENT GEMS
gem 'mina'
gem 'mina-multistage',  require: false
gem 'mina-unicorn', require: false

group :production, :staging do
  gem 'unicorn-rails'
end

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'spring'
  gem 'web-console', '~> 2.0'
end