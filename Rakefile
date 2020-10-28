# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('config/application', __dir__)

Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  namespace :test do
    task full: :environment do
      Rake::Task['rubocop:auto_correct'].invoke
      Rake::Task['test'].invoke
    end
  end
end

task 'db:schema:dump' => :environment do
  filename = 'db/schema.rb'
  sh "rubocop --auto-correct-all #{filename} > /dev/null"
  schema = File.read(filename)
               .gsub(', id: :serial', '')
               .gsub(/, id: :integer, default: -> { "nextval\('instructions_id_seq'::regclass\)" }/, '')
  File.write(filename, schema)
end
