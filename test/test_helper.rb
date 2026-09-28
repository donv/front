# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # The suite runs in well under a second, so forking workers would cost more than it saves. Forking
    # also crashes the precompiled pg gem on macOS (segfault in the child's first connection attempt).
    parallelize(workers: 1)
    fixtures :all

    def assert_no_errors(assigns_sym)
      assert_not_nil assigns(assigns_sym)
      assert_equal [], assigns(assigns_sym).errors.to_a
    end
  end
end

require 'authenticated_test_helper'
