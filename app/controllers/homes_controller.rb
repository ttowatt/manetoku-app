class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
  
  def about
  end

  def top
    @latest_period = current_user.periods.order(id: :desc).first # 最新登録の期間の取得
    @period = Period.new

    #表示している期間に紐づいているカテゴリだけを取得
    @categories = @latest_period ? current_user.categories.where(period: @latest_period) : []
    @category = Category.new

    @expense = Expense.new
    @categories.each do |category|
      category.expenses.build
    end 
  end
end
