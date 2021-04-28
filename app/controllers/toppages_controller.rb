class ToppagesController < ApplicationController
  def index
    if logged_in?
      @happy = Post.where("emotion = 'happy'")
    end
  end
end
