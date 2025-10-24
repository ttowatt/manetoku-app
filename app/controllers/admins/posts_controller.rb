class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice]= "会員の削除が成功しました"
    redirect_to admins_posts_path
  end
end
