class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page]).per(100)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice]= "会員の削除が成功しました"
    redirect_to admins_comments_path
  end
end
