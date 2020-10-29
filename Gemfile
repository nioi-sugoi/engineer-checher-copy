source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rails', '~> 5.2.3'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', :require => false
gem 'twitter'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'slim'
gem 'html2slim'
gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'
gem 'aws-sdk-rails'
gem 'aws-sdk-rekognition'
gem 'aws-sdk-comprehend'
gem 'kaminari'
gem 'chart-js-rails', '~> 0.1.4'
gem 'font-awesome-sass', '~> 5.4.1'
gem 'mini_magick'
gem 'meta-tags'
gem 'exception_notification'
gem 'slack-notifier'
gem 'redis-rails'
gem 'config'

group :development, :test do
  gem 'byebug', :platforms => [:mri, :mingw, :x64_mingw]
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rubocop', :require => false
  gem 'rubocop-performance', :require => false
  gem 'rubocop-rails', :require => false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', :platforms => [:mingw, :mswin, :x64_mingw, :jruby]
