class MainController < ApplicationController
  def root
    @articles = Article.page(params[:page]).per(5)
  end
end
