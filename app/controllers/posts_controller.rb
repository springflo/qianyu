class PostsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy, :thumb]
  before_action :correct_user, only: :destroy
 
  # GET /posts
  def index
    @posts = Post.all.sort_by {|p| -p.thumbs_count}.paginate(
          page: params[:page], per_page: 10)
  end
 
 
  # POST /posts(.:format) 
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
    @thumb = Thumb.find_by(user_id: current_user, post_id: params[:id])
    if @thumb.nil?
      @thumb = current_user.thumbs.build(post_id: params[:id], 
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

  # get posts/replies/:comment_id/:point
  # post页面获取评论的更多回复
  def replies
    @comment_id = params[:comment_id]
    @point = params[:point].to_i
    @step = 8
    @reply_part = Reply.where(comment_id: @comment_id)
  end
  

  private

    def post_params
      params.require(:post).permit(:content, :picture)
    end
    
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
