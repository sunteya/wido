class MainController < ApplicationController
  def root
    @articles = Article.published.page(params[:page]).per(5)
  end

  def atom
    @articles = Article.published.limit(20)
  end

  def archives
    @articles = Article.state([:published, :archived]).reorder("posted_at ASC")
  end

  def preivew
  end
end
