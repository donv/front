# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~>5.2.0'

# gem 'sports', path: '../sports'
gem 'sports', github: 'donv/sports'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'dynamic_form'
gem 'jquery-rails'
gem 'mini_racer'
gem 'pg'
gem 'puma'
gem 'rails-controller-testing'
gem 'RedCloth'
gem 'sass-rails'
gem 'slim-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'will_paginate'

group :development do
  gem 'listen'
  gem 'rubocop'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'minitest-reporters'
end
