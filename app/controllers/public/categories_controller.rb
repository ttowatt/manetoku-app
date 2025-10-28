class Public::CategoriesController < ApplicationController

  def new
    @category = Category.new
    @periods = current_user.periods
  end
  
  def create   
    latest_period = current_user.periods.order(id: :desc).first
    @category = current_user.categories.new(category_params)
    @category.period = latest_period

    if @category.save
      flash[:notice]= "カテゴリの追加が成功しました"
      redirect_to top_path
    else
      flash.now[:alert] = "カテゴリの追加に失敗しました"
      render "new"
    end
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end
  
  def update
    @category = current_user.categories.find(params[:id])
    if @category.update(category_params)
      redirect_to top_path, notice: "カテゴリを更新しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
    flash[:notice] = "カテゴリの削除が成功しました"
    redirect_to top_path
  end
  
  private

  def category_params
    params.require(:category).permit(:category_name, :budget)
  end
end
