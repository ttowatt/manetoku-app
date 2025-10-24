class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :user_controller?, except: [:about]
  before_action :authenticate_admin!, if: :admin_controller?, except: [:about]

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,:username, :introduction, :phone_number
    ])
  end

  private

  # ユーザー側（public 名前空間）のコントローラなら true
  def user_controller?
    self.class.name.deconstantize == Public
  end

  # 管理者側（admins 名前空間）のコントローラなら true
  def admin_controller?
    self.class.name.deconstantize == Admins
  end
end
