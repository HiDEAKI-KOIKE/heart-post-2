class ToppagesController < ApplicationController
  def index
    if logged_in?
      posts = Post.where(emotion: "happy")
      @happy = posts.order(id: :desc).page(params[:page])
    end
  end
end
