class PostsController < ApplicationController
  before_action :logged_in_user, only: [:creat, :destroy, :thumb]
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
  
  # Ajax 处理微博点赞
  def thumb
    # debugger
    @thumb = Thumb.find_by(user_id: params[:user_id], post_id: params[:id])
    @post = Post.find(params[:id])
    if @thumb.nil?
      @thumb = Thumb.create(user_id: params[:user_id], post_id: params[:id], 
                is_thumb: true)
      @post.thumbs_count +=1           
    elsif !!@thumb.is_thumb
      @thumb.is_thumb = false
      @post.thumbs_count -=1
    else
      @thumb.is_thumb = true
      @post.thumbs_count +=1 
    end
    @thumb.save!
    @post.save!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
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
