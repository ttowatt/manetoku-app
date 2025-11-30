class Public::PostLikesController < ApplicationController
  before_action :set_post

  def create
    current_user.post_likes.find_or_create_by(post: @post)
  end

  def destroy
    current_user.post_likes.find_by(post: @post)&.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
