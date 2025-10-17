class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
  
  def about
  end

  def top
    @now = Time.current
    @category = Category.new
    @category.expenses.build
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render :top
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "削除しました。"
  end

  private
  
  def post_params
    params.require(:post).permit(:category_name, :budget, :amount, :expense_date)
  end
end
