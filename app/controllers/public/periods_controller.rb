class Public::PeriodsController < ApplicationController
  def index
    #新しい期間（最新のstart_date）から順に並べる
      @periods = current_user.periods.includes(:categories).order(start_date: :desc)
  end

  def show
    @period = current_user.periods.find(params[:id])

    # この期間に紐づくカテゴリを事前に支出も含めて取得
    @categories = @period.categories.includes(:expenses)
  end

  def create
    @period = current_user.periods.new(period_params)
  
    if @period.save
      # 直前の期間を取得(最新の期間を1件のみ表示)
      previous_period = current_user.periods.order(created_at: :desc).second
  
      # 前の期間が存在すれば、そのカテゴリを引き継ぐ
      if previous_period.present?
        previous_period.categories.each do |category|
          @period.categories.create!(
            user: current_user,
            category_name: category.category_name,
            budget: category.budget
          )
        end
      end
  
      flash[:notice] = "期間が作成されました（前のカテゴリを引き継ぎました）"
      redirect_to root_path
    else
      flash.now[:alert] = "期間の作成に失敗しました"
      render "homes/top"
    end
  end

  def edit
    @period = current_user.periods.find(params[:id])
  end
  
  def update
    @period = current_user.periods.find(params[:id])
    if @period.update(period_params)
      redirect_to root_path, notice: "カテゴリ名を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @period = current_user.periods.find(params[:id])
    @period.destroy
    flash[:notice] = "期間を削除しました"
    redirect_to root_path
  end

  private

  def period_params
    params.require(:period).permit(:start_date, :end_date)
  end
end
