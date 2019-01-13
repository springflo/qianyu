class PasswordResetsController < ApplicationController
  before_action :get_user,  only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only:[:edit, :update]
  
  
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "重置密码确认已发送至您的邮件，请查收"
      redirect_to root_path
    else 
      flash.now[:danger] = "邮件地址错误"
      render 'new'
    end
  end
  

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "不能为空")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "密码重置成功！"
      redirect_to @user
    else 
      render 'edit'
    end
  end
  
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    # 确保是有效用户
    def valid_user
      unless (@user && @user.activated? && 
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_path
      end
    end
    
    # 检查重设令牌是否过期
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "密码重置过期，请重新申请修改密码"
        redirect_to new_password_reset_url
      end
    end
    
  
end
