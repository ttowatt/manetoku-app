class Public::PostLikesController < ApplicationController
  before_action :set_post

  def create
    like = @post.post_likes.new(user: current_user)
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
    like = post.post_likes.find_by(user: current_user)
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

  def set_post
    @post = Post.find(params[:post_id])
  end
end
