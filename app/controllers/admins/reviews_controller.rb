class Admins::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice]= "会員の削除が成功しました"
    redirect_to admins_reviews_path
  end
end
