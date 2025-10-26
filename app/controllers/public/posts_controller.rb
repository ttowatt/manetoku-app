class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.includes(:user, :reviews).order(created_at: :desc)
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice]= "投稿が成功しました"
      redirect_to public_posts_path
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.includes(:reviews, :user).find(params[:id])
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice]= "投稿の削除が成功しました"
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:category, :title, :body, :image)
  end
end
