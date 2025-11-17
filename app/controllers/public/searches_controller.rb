class Public::SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    @model   = params[:model]

    if @model == "user"
      @q = User.ransack(username_cont: @keyword)
      @results = @q.result(distinct: true).page(params[:page]).per(30)

    elsif @model == "post"
      @q = Post.ransack(title_or_body_or_category_cont: @keyword)
      @results = @q.result(distinct: true).page(params[:page]).per(15)
    else
      @results = []
    end
  end
end
