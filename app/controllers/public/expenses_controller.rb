class Public::ExpensesController < ApplicationController
  
  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      flash[:alert] = "登録に失敗しました"
      redirect_to root_path
    end
  end

  def update
    if @expense.update(period_params)
      redirect_to public_histories_path, notice: "更新しました。"
    else
      render :top
    end
  end

  def destroy
    @expense.destroy
    redirect_to public_histories_path, notice: "削除しました。"
  end
  
  def expense_params
    params.require(:expense).permit(:amount, :expense_date, :category_id, :period_id)
  end
end
