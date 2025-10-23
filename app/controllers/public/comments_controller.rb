class Public::CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
  if @comment.save
    redirect_to public_post_comments_path(@post), notice: "コメントを投稿しました。"
  else
    redirect_to public_post_comments_path(@post), alert: "コメントの投稿に失敗しました。"
  end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to public_post_comments_path(comment.post), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
