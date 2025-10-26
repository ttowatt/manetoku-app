class Public::LikesController < ApplicationController
  before_action :set_post, only: [:create_post, :destroy_post]
  before_action :set_comment, only: [:create_comment, :destroy_comment]

  def index
  end
  
  #投稿にいいね
  def create_post
    @post.likes.create(user: current_user)
    respond_to do |format|
      format.html {redirect_to public_posts_path}
      format.js #Ajax時にcreate_post.js.erbを探す
    end
  end

  #コメントにいいね
  def create_comment
    @comment.likes.create(user: current_user)
    respond_to do |format|
      format.html {redirect_to public_post_comments_path(@comment.post)}
      format.js #Ajax時にcreate_comment.js.erbを探す
    end
  end
  
  def destroy_post
    like = @post.likes.find_by(user: current_user)
    like.destroy 
    respond_to do |format|
      format.html {redirect_to public_posts_path}
      format.js  #Ajax時にdestroy_post.js.erbを探す
    end
  end

  def destroy_comment
    like = @comment.likes.find_by(user: current_user)
    like.destroy
    respond_to do |format|
      format.html {redirect_to public_post_comments_path(@comment.post)}
      format.js  #Ajax時にdestroy_comment.js.erbを探す
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end
