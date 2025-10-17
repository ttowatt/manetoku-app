class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top]
  
  def top
    @article = Article.last
  end

  def about
  end
end
