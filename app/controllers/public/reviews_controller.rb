class Public::ReviewsController < ApplicationController
  before_action :set_post

  def new
    @review = Review.new
  end
  
  def index
    @reviews = @post.reviews.includes(:user).order(created_at: :desc)
  end
  
  def create
    @review = @post.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to public_post_reviews_path(@post), notice: "レビューを投稿しました"
    else
      redirect_to new_public_post_review_path(@post), alert: "レビューを投稿に失敗しました"
    end
  end
  
  def show
    @review = @post.reviews.find(params[:id])
  end
  
  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice]= "評価の削除が成功しました"
    redirect_to public_post_reviews_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def review_params
    params.require(:review).permit(:star, :body)
  end
end
