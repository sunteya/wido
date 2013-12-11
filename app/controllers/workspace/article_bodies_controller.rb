class Workspace::ArticleBodiesController < ApplicationController
  def show
    @article_body = current_user.article_bodies.find(params[:id])
    render layout: "simple"
  end

  def update
    @article_body = current_user.article_bodies.find(params[:id])
    
    if @article_body.update_attributes(article_body_params)
      render json: @article_body
    else
      render json: @article_body.errors, status: :unprocessable_entity
    end
  end

protected
  def article_body_params
    params.require(:article_body).permit(
          :id, :content, attachments_attributes: [ :id, :file, :_destroy ]
        ) if params[:article_body]
  end
end
