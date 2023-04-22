source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "faraday"
gem "figaro"
gem "jsonapi-serializer"
gem 'bcrypt'

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "launchy"
  gem 'shoulda-matchers'
  gem 'orderly'
  gem 'factory_bot_rails'
  gem "faker"
  gem "pry"
end

group :development do
end

group :test do 
  gem "simplecov"
  gem 'vcr'
  gem 'webmock'
end 