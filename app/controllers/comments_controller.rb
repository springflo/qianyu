class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy]
  # before_action :correct_user, only: :destroy  
  
  def create
    # debugger
    @comment = Comment.new(content: params[:content], user_id: current_user.id,
                post_id: params[:post_id])
    if @comment.save
      flash[:success] = "评论成功！"
    else 
      flash[:warning] = "评论失败！"
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:post_id, :content).permit(:post_id, :content, :id)
    end
    
end
