class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else 
        message = "账户未激活"
        message += "注意查收激活邮件"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '邮箱或密码错误！'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
