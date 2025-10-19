class Public::CategoriesController < ApplicationController

  def new
    @category = Category.new
  end
  
  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:notice]= "カテゴリの追加が成功しました"
      redirect_to root_path
    else
      @categories = Category.new
      render "new"
    end
  end
  
  def update
    if @ctegory.update(category_params)
      redirect_to root_path(@user), notice: "カテゴリ名の更新に成功しました"
    else
      render "top"
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
    params.require(:category).permit(:category_name, :budget,)
  end
end
