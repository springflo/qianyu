class AccountActivationController < ApplicationController
    def edit 
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            # user.update_attribute(:activated, true)
            # user.update_attribute(:activated_at, Time.zone.now)
            user.activate
            
            log_in user
            flash[:success] = "账号已激活！"
            redirect_to user
        else 
            flash[:danger] = "无效激活"
            redirect_to root_url
        end
    end
end