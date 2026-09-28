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

  def test_remember_me_cookie_reaches_a_protected_engine_page_without_logging_in
    users(:quentin).remember_me
    cookies[:remember_token] = users(:quentin).remember_token
    get '/blog/blogs/new'
    assert_response :success
  end

  def test_login_cookies_cover_every_subdomain_and_are_hidden_from_scripts
    post '/account/login', params: { login: 'quentin', password: 'test', remember_me: '1' }
    assert_match(/_kubosch_session=\S+ domain=example\.com;.*httponly/i, set_cookies)
    assert_match(/remember_token=\S+ domain=example\.com;.*httponly/i, set_cookies)
  end

  def test_logout_removes_the_remember_me_cookie_from_the_whole_domain
    post '/account/login', params: { login: 'quentin', password: 'test', remember_me: '1' }
    get '/account/logout'
    assert_match(/remember_token=; domain=example\.com;.*expires=Thu, 01 Jan 1970/i, set_cookies)
  end

  def test_login_without_a_stored_location_goes_to_the_front_page
    post '/account/login', params: { login: 'quentin', password: 'test' }
    assert_redirected_to '/'
  end

  private

  def set_cookies
    Array(response.headers['set-cookie']).join("\n")
  end
end
