class Public::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @category = Category.new
  end
  
  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:notice]= "カテゴリの追加が成功しました"
      redirect_to public_categories_path
    else
      @categories = Category.all
      render 'index'
    end
  end
  
  def update
    if @ctegory.update(category_params)
      redirect_to public_categories_path(@user), notice: "カテゴリ名の更新に成功しました"
    else
      render "index"
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice]= "カテゴリの削除が成功しました"
    redirect_to public_categories_path
  end
  
  private

  def category_params
    params.require(:category).permit(
      :name, :budget,
      expenses_attributes: [:id, :amount, :expense_date, :_destroy]
    )
  end
end
