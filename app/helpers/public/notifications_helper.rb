module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "フォローしている#{notification.notifiable.user.username}さんが#{notification.notifiable.title}を投稿しました"
    end
  end
end
