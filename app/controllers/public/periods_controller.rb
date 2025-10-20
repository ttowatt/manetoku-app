class Public::PeriodsController < ApplicationController
  def index
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      redirect_to root_path, notice: "登録が完了しました"
    else
      render :top
    end
  end

  def update
    if @period.update(period_params)
      redirect_to root_path, notice: "更新しました。"
    else
      render :top
    end
  end

  def destroy
    @period.destroy
    redirect_to public_histories_path, notice: "削除しました。"
  end

  private

  def period_params
    params.require(:period).permit(:start_date, :end_date,)
  end
end
