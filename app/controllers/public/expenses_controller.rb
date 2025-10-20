class Public::ExpensesController < ApplicationController
  
  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render "top"
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
end
