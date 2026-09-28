# frozen_string_literal: true

require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper

  def test_index
    get :index
    assert_response :success
    assert_select 'a', text: 'The Blog'
    assert_select 'a', text: 'Sports', count: 0
  end

  def test_index_logged_in_shows_sports_section
    login_as :quentin
    get :index
    assert_response :success
    assert_select 'a[href=?]', '/sports', text: 'Sports'
  end
end
