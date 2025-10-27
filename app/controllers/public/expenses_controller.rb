class Public::ExpensesController < ApplicationController
  
  def create
    @expense = current_user.expenses.new(expense_params)
    @latest_period = Period.last
    @categories = current_user.categories.where(period_id: @latest_period.id)
    @period = Period.new  # homes/topで使うフォーム用

    if @expense.save
      redirect_to root_path, notice: "支出を登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render "homes/top"
    end
  end

  def edit
    @expense = current_user.expenses.find(params[:id])
  end

  def update
    @expense = current_user.expenses.find(params[:id])
    if @expense.update(expense_params)
      redirect_to public_period_path(@expense.period_id), notice: "支出を更新しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @expense = current_user.expenses.find(params[:id])
    @expense.destroy
    flash[:notice] = "支出の削除が成功しました"
    redirect_to public_period_path(@expense.period_id)
  end
  
  def expense_params
    params.require(:expense).permit(:amount, :expense_date, :category_id, :period_id)
  end
end
