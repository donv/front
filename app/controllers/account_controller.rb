# frozen_string_literal: true

class AccountController < ApplicationController
  include AuthenticatedSystem

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
    @user = User.new(user_params)
    return unless request.post?

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

  def store_remember_me
    return unless params[:remember_me] == '1'

    current_user.remember_me
    remember_current_user
  end

  def user_params
    params.expect(user: %i[email login password password_confirmation])
  end
end
