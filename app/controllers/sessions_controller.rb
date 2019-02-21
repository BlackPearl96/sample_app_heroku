class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    # if user && user.authenticate(params[:session][:password])
    if user&.authenticate(params[:session][:password])
      flash[:success] = t "welcome"
      log_in user
      redirect_to user
    else
      flash[:danger] = t "error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
