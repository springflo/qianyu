class RepliesController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy]
  before_action :correct_user, only: :destroy
  
  
  
  def create
    @reply = current_user.replies.build(content: params[:content],
                comment_id: params[:comment_id], replied_id: params[:replied_id])
    # Reply.new(content: params[:content], user_id: current_user.id,
    #             comment_id: params[:comment_id], replied_id: params[:replied_id])
    if @reply.save
      flash[:success] = "回复成功！"
    else 
      flash[:warning] = "回复失败！请检查输入（不能为空，且少于400字符）！"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    flash[:success] = "删除成功！"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def correct_user
      @reply = current_user.replies.find_by(id: params[:id])
      redirect_to root_url if @reply.nil?
    end  
  
end
