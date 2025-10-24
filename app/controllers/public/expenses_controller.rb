class Public::ExpensesController < ApplicationController
  
  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to root_path, notice: "支出の登録が成功しました"
    else
      flash[:alert] = "支出の登録に失敗しました"
      redirect_to root_path
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
