class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.reverse_notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = current_user.reverse_notifications.find(params[:id])
    @notification.update(is_read: true)
    redirect_to public_notifications_path, notice: "通知を既読にしました"
  end

  def mark_all_as_read
    current_user.reverse_notifications.update_all(is_read: true)
    redirect_to public_notifications_path, notice: "すべて既読にしました"
  end
end
