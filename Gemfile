# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby File.read("#{__dir__}/.ruby-version")[5..]

gem 'rails', '~> 7.2.4'

gem 'blog_engine',
    # path: '../blog'
    github: 'donv/blog', branch: 'master'
gem 'sports',
    # path: '../sports'
    github: 'donv/sports', branch: 'master'

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
# Dart Sass instead of the unmaintained libsass binding, which segfaults on Linux. The sassc entry is
# a shim that loads sassc-embedded, satisfying bootstrap-sass and sassc-rails without compiling libsass.
gem 'sassc', github: 'sass/sassc-ruby', ref: 'refs/pull/233/head'
gem 'sassc-embedded'
gem 'serviceworker-rails'
gem 'slim-rails'
gem 'terser'
gem 'turbolinks'
gem 'will_paginate'

# The Rails 7.x test runner does not support minitest 6; drop this pin with Rails 8.
gem 'minitest', '< 6'

group :development do
  gem 'listen'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'web-console'
end
