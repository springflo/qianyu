class PostsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy, :thumb]
  before_action :correct_user, only: :destroy
 
 
  #POST /posts(.:format) 
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
  
  # post GET    /posts/:id(.:format) 
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
    if @comment.nil?
      @comment = Comment.new
    end
  end
  
  
  # thumb_post  GET  /posts/:id/thumb(.:format)
  # Ajax 处理微博点赞
  def thumb
    # debugger
    @thumb = Thumb.find_by(user_id: params[:user_id], post_id: params[:id])
    if @thumb.nil?
      @thumb = Thumb.create(user_id: params[:user_id], post_id: params[:id], 
                is_thumb: true)
    elsif !!@thumb.is_thumb
      @thumb.is_thumb = false
    else
      @thumb.is_thumb = true
    end
    @thumb.save!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  
  
  def comment
  end
  
  def reply
  end
  

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :picture)
    end
    
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
