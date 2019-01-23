class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    # debugger
    @comment = current_user.comments.build(content: params[:content], 
                post_id: params[:post_id])
    # Comment.new(content: params[:content], user_id: current_user.id,
    #             post_id: params[:post_id])
    if @comment.save
      flash[:success] = "评论成功！"
    else 
      flash[:warning] = "评论失败！请检查输入（不能为空，且少于400字符）！"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
      flash[:success] = "删除成功！"
    redirect_to request.referrer || root_url
  end
  
  
  private
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end  
    
end
