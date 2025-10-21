class Public::PeriodsController < ApplicationController
  def index
      @periods = current_user.periods.includes(:categories).order(start_date: :desc)
  end

  def show
  end

  def create
    @period = Period.new(period_params)
    @period.user_id = current_user.id
    if @period.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      redirect_to root_path, alert: "登録に失敗しました"
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
    @period.destroy
    redirect_to public_histories_path, notice: "削除しました。"
  end

  private

  def period_params
    params.require(:period).permit(:start_date, :end_date)
  end
end
