class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
  
  def about
  end

  def top
    @now = Time.current
    @categories = Category.all
    @category = Category.new
    @categories = current_user.categories.includes(:histories)
    @category.expenses.build
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render "top"
    end
  end

  def update
    if @category.update(category_params)
      redirect_to root_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: "削除しました。"
  end

  private
  
  def expense_params
    params.require(:expense).permit(:amount, :expense_date)
  end
end
