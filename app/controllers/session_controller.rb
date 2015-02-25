class SessionController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by_name params[:name]
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to login_url, flash: {:alert => 'wrong username/password'}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
