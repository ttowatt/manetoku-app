class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
  
  def about
  end

  def top
    @categories = Category.all
    @category = Category.new
    @category.expenses.build #各カテゴリに紐づく支出のオブジェクトを作成
    @latest_period = current_user.periods.order(id: :desc).first # 最新登録の期間の取得
    @period = Period.new
    @expense = Expense.new
  end
end
