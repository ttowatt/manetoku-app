class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :user_controller?, except: [:about]
  before_action :authenticate_admin!, if: :admin_controller?, except: [:about]

  before_action :configure_permitted_parameters, if: :devise_controller?

   # ログイン後の遷移先
   def after_sign_in_path_for(resource)
    top_path
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,:username, :introduction, :phone_number
    ])
  end

  private

  # ユーザー側（public 名前空間）のコントローラなら true
  def user_controller?
    controller_path.start_with?("public/")
  end

  # 管理者側（admins 名前空間）のコントローラなら true
  def admin_controller?
    controller_path.start_with?("admins/")
  end

  #未読通知
  def set_unread_notifications
      @unread_notifications = current_user.reverse_notifications.where(is_read: false)
  end
end
