class PostsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy]
  before_action :correct_user, only: :destroy
 
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "发布成功！"
      redirect_to root_url
    else 
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    flash[:success] = "文章删除成功"
    redirect_to request.referrer || root_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      # params.require(:post).permit(:title, :content)
      params.require(:post).permit(:content, :picture)
    end
    
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
