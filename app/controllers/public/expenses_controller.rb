class Public::ExpensesController < ApplicationController
  
  def create
    @expense = current_user.expenses.new(expense_params)

     # 最新の期間を取得
    latest_period = current_user.periods.order(id: :desc).first
    unless latest_period
      flash[:alert] = "期間が登録されていません。先に期間を登録してください。"
      return redirect_to root_path
    end

    @expense.period = latest_period

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
    params.require(:expense).permit(:amount, :expense_date, :category_id)
  end
end
