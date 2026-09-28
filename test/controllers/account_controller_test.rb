# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../test_helper"

class AccountControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :users

  def test_should_login_and_redirect
    post :login, params: { login: 'quentin', password: 'test' }
    assert session[:user]
    assert_response :redirect
  end

  def test_should_fail_login_and_redirect
    post :login, params: { login: 'quentin', password: 'bad password' }
    assert_nil session[:user]
    assert_response :redirect
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:user]
    assert_response :redirect
  end

  def test_should_remember_me
    post :login, params: { login: 'quentin', password: 'test', remember_me: '1' }
    assert_not_nil @response.cookies['remember_token']
  end

  def test_should_not_remember_me
    post :login, params: { login: 'quentin', password: 'test', remember_me: '0' }
    assert_nil @response.cookies['remember_token']
  end

  def test_should_delete_token_on_logout
    login_as :quentin
    get :logout
    assert_nil @response.cookies[:remember_token]
  end

  def test_should_login_with_cookie
    users(:quentin).remember_me
    cookies[:remember_token] = cookie_for(:quentin)
    get :index
    assert_equal 1, session[:user]
  end

  def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    cookies['remember_token'] = cookie_for(:quentin)
    get :index
    assert_not @controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies['remember_token'] = remember_cookie('invalid_token')
    get :index
    assert_not @controller.send(:logged_in?)
  end

  protected

  def remember_cookie(token)
    CGI::Cookie.new('name' => 'remember_token', 'value' => token)
  end

  def cookie_for(user)
    users(user).remember_token
  end
end
