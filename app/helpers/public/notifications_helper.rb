module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "フォローしている#{notification.notifiable.user.username}さんが新しい投稿をしました"
    else
      "通知があります"
    end
  end
end
