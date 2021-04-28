class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if @post.emotion == "happy" then
        flash[:success] = '投稿しました。'
        redirect_to root_path
      elsif @post.emotion == "relax" then
        flash[:success] = '投稿しました。'
        redirect_to relax_posts_path
      elsif @post.emotion == "sad" then
        flash[:success] = '投稿しました。'
        redirect_to sad_posts_path
      else
        flash[:success] = '投稿しました。'
        redirect_to tired_posts_path
      end
    else
        @posts = current_user.posts.order(id: :desc).page(params[:page])
        flash.now[:danger] = '投稿に失敗しました。'
        render 'posts/new'
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def relax
    @relax = Post.where(emotion: 'relax')
  end

  def sad
    @sad = Post.where(emotion: 'sad')
  end

  def tired
    @tired = Post.where(emotion: 'tired')
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :emotion)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
