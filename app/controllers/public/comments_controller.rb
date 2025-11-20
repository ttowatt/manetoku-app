class Public::CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(50)
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_comments_path(@post), notice: "コメントを投稿しました。"
    else
      render 'index'
    end
  end
  
  def destroy
    comment = current_user.comment.find(params[:id])
    comment.destroy
    redirect_to post_comments_path(comment.post), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
