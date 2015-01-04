ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

MiniTest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all

  def assert_no_errors(assigns_sym)
    assert_not_nil assigns(assigns_sym)
    assert_equal [], assigns(assigns_sym).errors.to_a
  end

end

require 'authenticated_test_helper'
