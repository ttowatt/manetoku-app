class Public::FollowsController < ApplicationController
  before_action :set_user

    def create
      current_user.following << @user

      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js   # create.js.erb を呼ぶ
      end
    end

    def destroy
      current_user.following.delete(@user)

      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js   # destroy.js.erb を呼ぶ
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
end
