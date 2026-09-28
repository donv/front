# frozen_string_literal: true

require 'test_helper'

# Sign-up only exists to create the first account; after that it is closed.
class AccountSignupTest < ActionDispatch::IntegrationTest
  fixtures :users

  def test_should_allow_signup_of_the_first_user
    User.delete_all
    assert_difference('User.count') do
      create_user
      assert_no_errors :user
      assert_response :redirect
    end
  end

  def test_should_refuse_signup_once_a_user_exists
    assert_no_difference('User.count') do
      create_user
    end
    assert_redirected_to '/account/login'
  end

  def test_should_show_the_signup_form_only_until_the_first_user
    get '/account/signup'
    assert_redirected_to '/account/login'
    User.delete_all
    get '/account/signup'
    assert_response :success
  end

  def test_should_require_login_on_signup
    assert_signup_refused_without :login
  end

  def test_should_require_password_on_signup
    assert_signup_refused_without :password
  end

  def test_should_require_password_confirmation_on_signup
    assert_signup_refused_without :password_confirmation
  end

  def test_should_require_email_on_signup
    assert_signup_refused_without :email
  end

  private

  def assert_signup_refused_without(field)
    User.delete_all
    assert_no_difference('User.count') do
      create_user(field => nil)
      assert assigns(:user).errors[field].any?
      assert_response :success
    end
  end

  def create_user(options = {})
    user = { login: 'quire', email: 'quire@example.com',
             password: 'quire', password_confirmation: 'quire' }
    post '/account/signup', params: { user: user.merge(options) }
  end
end
