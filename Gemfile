# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby File.read("#{__dir__}/.ruby-version")[5..]

gem 'rails', '~>6.1.4'

gem 'blog_engine',
    # path: '../blog'
    github: 'donv/blog'
gem 'sports',
    # path: '../sports'
    github: 'donv/sports'

gem 'bcrypt'
gem 'bootsnap'
gem 'chunky_png'
gem 'coffee-rails'
gem 'mini_mime'
gem 'oily_png'
gem 'pg'
gem 'puma'
gem 'rails-controller-testing'
gem 'RedCloth'
gem 'sass-rails'
gem 'serviceworker-rails'
gem 'slim-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'will_paginate'

group :development do
  gem 'listen'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'web-console'
end
