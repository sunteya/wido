class MainController < ApplicationController
  def root
    @articles = Article.page(params[:page]).reorder("created_at DESC").per(5)
  end

  def atom
    @articles = Article.reorder("created_at DESC").limit(20)
  end
end
