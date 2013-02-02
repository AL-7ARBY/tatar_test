source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'compass-rails'
  gem 'zurb-foundation'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'slim-rails'

# https://github.com/ernie/squeel
gem 'squeel'

group :development do
  gem 'quiet_assets'
  gem 'rails_best_practices'

  # с другого git'а чтобы работало с falcon patch
  gem 'looksee', git: 'git://github.com/fxposter/looksee.git'

  # https://github.com/schneems/sextant
  gem 'sextant'

  # for rails panel chrome plugin
  gem 'meta_request', '0.2.0'

  # https://github.com/charliesome/better_errors
  gem "binding_of_caller"
  gem 'better_errors'          
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'database_cleaner'

  gem 'factory_girl_rails'
end

# чисто для теста, чтобы страницу забить текстом. По хорошему это должно быть
# в предыдущей группе
gem 'faker'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
