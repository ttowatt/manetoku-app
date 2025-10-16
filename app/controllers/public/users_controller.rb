class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = @user.posts
  end
  
  def index
   @users = User.all
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @user.update(user_params)
      redirect_to public_mypage_path(@user), notice: "プロフィールの更新に成功しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy
    reset_session  # ログアウトさせる
    redirect_to about_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  def withdraw_confirm
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to public_mypage_path(current_user) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :username, :introduction, :phone_number, :email, :profile_image
      )
  end
end
