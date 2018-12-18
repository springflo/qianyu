class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    # debugger
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      
      flash[:info] = "请查收邮件以激活账号"
      # log_in @user      # session[:user_id] = user.id
      # flash[:success] = "Welcome!"
      # redirect_to @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "删除用户成功！"
    redirect_to users_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    # 健壮参数
    def user_params
      params.require(:user).permit(:email, :username, :password, 
                    :password_confirmation)
    end
    
    # 前置过滤器
    
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请先登录！"
        redirect_to login_url
      end
    end
    
    # 确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
