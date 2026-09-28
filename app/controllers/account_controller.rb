# frozen_string_literal: true

class AccountController < ApplicationController
  include AuthenticatedSystem

  before_action :signup_only_until_the_first_user, only: :signup

  def index
    redirect_to(action: :signup) unless logged_in? || User.any?
  end

  def login
    return unless request.post?

    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      store_remember_me
      flash.notice = 'Logged in successfully'
    else
      flash.alert = 'Bad user name or password.'
    end
    redirect_back_or_default controller: 'welcome', action: 'index'
  end

  def signup
    @user = User.new
    return unless request.post?

    @user.assign_attributes(user_params)
    @user.save!
    self.current_user = @user
    redirect_back_or_default(controller: '/account', action: 'index')
    flash[:notice] = 'Thanks for signing up!'
  rescue ActiveRecord::RecordInvalid
    render action: 'signup'
  end

  def logout
    current_user.forget_me if logged_in?
    forget_current_user
    reset_session
    flash[:notice] = 'You have been logged out.'
    redirect_back_or_default(controller: :welcome, action: :index)
  end

  private

  # Sign-up only bootstraps the first account. After that, accounts are not self-service, since a
  # login grants access to the sports section and to editing the blog.
  def signup_only_until_the_first_user
    return if User.none?

    flash.alert = 'Sign-up is closed.'
    redirect_to account_login_path
  end

  def store_remember_me
    return unless params[:remember_me] == '1'

    current_user.remember_me
    remember_current_user
  end

  def user_params
    params.expect(user: %i[email login password password_confirmation])
  end
end
