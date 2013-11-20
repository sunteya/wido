class ArticlesController < ApplicationController
  def show
    @author = User.where(slug: params[:author]).first!
    @article = @author.articles.find(params[:article])
  end
end
