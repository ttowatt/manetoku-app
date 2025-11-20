class Public::NotificationsController < ApplicationController

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
  
    # 通知が Post の場合はその投稿の show へ飛ばす
    if notification.notifiable_type == "Post"
      redirect_to post_path(notification.notifiable_id)
    else
      redirect_to posts_path, notice: "通知を確認しました"
    end
  end
end
