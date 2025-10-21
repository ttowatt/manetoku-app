class Public::CategoriesController < ApplicationController

  def new
    @category = Category.new
    @periods = current_user.periods
  end
  
  def create
    @category = current_user.categories.new(category_params)
     
    latest_period = current_user.periods.last # 最新の期間を1つだけ取り出す（なければ nil になる）
    
    if latest_period # もし期間があれば、その期間をカテゴリに結びつける
      @category.period = latest_period
    end

    if @category.save
      flash[:notice]= "カテゴリの追加が成功しました"
      redirect_to root_path
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
      redirect_to root_path, notice: "カテゴリ名を更新しました"
    else
      render "edit"
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice]= "カテゴリの削除が成功しました"
    redirect_to root_path
  end
  
  private

  def category_params
    params.require(:category).permit(:category_name, :budget)
  end
end
