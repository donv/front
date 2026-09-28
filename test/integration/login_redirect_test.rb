# frozen_string_literal: true

require 'test_helper'

class LoginRedirectTest < ActionDispatch::IntegrationTest
  fixtures :users

  def test_protected_page_sends_a_visitor_to_login_and_back_again
    get '/blog/blogs/new'
    assert_redirected_to '/account/login'
    post '/account/login', params: { login: 'quentin', password: 'test' }
    assert_redirected_to '/blog/blogs/new'
  end

  def test_login_without_a_stored_location_goes_to_the_front_page
    post '/account/login', params: { login: 'quentin', password: 'test' }
    assert_redirected_to '/'
  end
end
