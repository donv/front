# frozen_string_literal: true

class AccountController < ApplicationController
  include AuthenticatedSystem

  def index
    redirect_to(action: :signup) unless logged_in? || User.count > 0
  end

  def login
    return unless request.post?

    self.current_user = User.authenticate(params[:login], params[:password])
    return unless logged_in?

    if params[:remember_me] == '1'
      current_user.remember_me
      cookies[:auth_token] = { value: current_user.remember_token, expires: current_user.remember_token_expires_at }
    end
    redirect_back_or_default(controller: 'welcome', action: 'index')
    flash[:notice] = 'Logged in successfully'
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
    cookies.delete :auth_token
    reset_session
    flash[:notice] = 'You have been logged out.'
    redirect_back_or_default(controller: :welcome, action: :index)
  end

  private

  def user_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation)
  end
end
