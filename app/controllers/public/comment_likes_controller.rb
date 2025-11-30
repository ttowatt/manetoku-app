class Public::CommentLikesController < ApplicationController
  before_action :set_comment

  def create
    current_user.comment_likes.find_or_create_by(comment: @comment)
  end

  def destroy
    current_user.comment_likes.find_by(comment: @comment)&.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end

