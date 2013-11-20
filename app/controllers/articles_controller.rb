class ArticlesController < ApplicationController
  def show
    @author = User.where(slug: params[:author]).first!
    @article = @author.articles.where("slug=? OR id=?", params[:article], params[:article].to_i).first
  end
end
