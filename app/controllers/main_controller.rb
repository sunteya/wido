class MainController < ApplicationController
  def root
    @articles = Article.page(params[:page]).reorder("created_at DESC").per(5)
  end
end
