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

  def test_should_allow_signup
    assert_difference User, :count do
      create_user
      assert_no_errors :user
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference User, :count do
      create_user(login: nil)
      assert assigns(:user).errors[:login]
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference User, :count do
      create_user(password: nil)
      assert assigns(:user).errors[:password]
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference User, :count do
      create_user(password_confirmation: nil)
      assert assigns(:user).errors[:password_confirmation]
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference User, :count do
      create_user(email: nil)
      assert assigns(:user).errors[:email]
      assert_response :success
    end
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:user]
    assert_response :redirect
  end

  def test_should_remember_me
    post :login, params: { login: 'quentin', password: 'test', remember_me: '1' }
    assert_not_nil @response.cookies['auth_token']
  end

  def test_should_not_remember_me
    post :login, params: { login: 'quentin', password: 'test', remember_me: '0' }
    assert_nil @response.cookies['auth_token']
  end

  def test_should_delete_token_on_logout
    login_as :quentin
    get :logout
    assert_nil @response.cookies[:auth_token]
  end

  def test_should_login_with_cookie
    users(:quentin).remember_me
    cookies[:auth_token] = cookie_for(:quentin)
    get :index
    assert_equal 1, session[:user]
  end

  def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    cookies['auth_token'] = cookie_for(:quentin)
    get :index
    assert_not @controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies['auth_token'] = auth_token('invalid_auth_token')
    get :index
    assert_not @controller.send(:logged_in?)
  end

  protected

  def create_user(options = {})
    post :signup, params: { user: { login: 'quire', email: 'quire@example.com',
                                    password: 'quire', password_confirmation: 'quire' }.merge(options) }
  end

  def auth_token(token)
    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  end

  def cookie_for(user)
    users(user).remember_token
  end
end
