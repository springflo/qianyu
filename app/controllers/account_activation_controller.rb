class AccountActivationController < ApplicationController
    def edit 
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            # user.update_attribute(:activated, true)
            # user.update_attribute(:activated_at, Time.zone.now)
            user.activate
            flash[:success] = "账号已激活"
            # log_in user
            redirect_to login_url
        elsif user.activated?
            flash[:success] = "账号已激活"
            redirect_to login_url
        else 
            flash[:danger] = "激活失败"
            redirect_to root_url
        end
    end
end
