class Public::CommentLikesController < ApplicationController
  before_action :set_comment

  def create
    like = @comment.comment_likes.new(user: current_user)
    if like.save
      respond_to do |format|
        format.js   # create.js.erb が呼ばれる
      end
    else
      respond_to do |format|
        format.js { render js: "alert('いいねに失敗しました');" }
      end
    end
  end

  def destroy
    like = @comment.comment_likes.find_by(user: current_user)
    if like&.destroy
      respond_to do |format|
        format.js   # destroy.js.erb が呼ばれる
      end
    else
      respond_to do |format|
        format.js { render js: "alert('操作に失敗しました');" }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end

