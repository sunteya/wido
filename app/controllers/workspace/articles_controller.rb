class Workspace::ArticlesController < Workspace::BaseController
  before_filter :find_collection

  def index
    redirect_to collection_route(@collection).root_path
  end
  
  def show
    @article = @collection.articles.find(params[:id])
    @article_version = @article.versions.find(params[:ver]) if params[:ver]
  end

  def new
    @article = @collection.articles.scope.new(article_params)
  end

  def create
    @article = @collection.articles.scope.new(article_params)
    @article_body = current_user.article_bodies.find(params[:article_body_id])
    @article_body.update_attributes!(article_body_params)

    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to collection_route(@collection).article_path(@article)
    else
      render action: "new"
    end
  end

  def edit
    @article = @collection.articles.find(params[:id])
    @article.taken_snapshot
  end

  def update
    @article = @collection.articles.find(params[:id])
    @article.taken_snapshot
    @article_body = current_user.article_bodies.find(params[:article_body_id])
    @article_body.update_attributes!(article_body_params)
    @article.editing_body_id = @article_body.id

    if @article.update_attributes(article_params)
      flash[notice] = 'Article was successfully updated.'
      
      if @collection.include?(@article)
        redirect_to collection_route(@collection).article_path(@article)
      else
        redirect_to collection_route(@collection).articles_path
      end
    else
      render "edit"
    end
  end

  def destroy
    @article = @collection.articles.find(params[:id])
    @article.destroy

    redirect_to collection_route(@collection).root_path
  end
  
protected
  def article_params
    params.require(:article).permit(
          :title, :slug, :state, :tag_list, :list_id, :posted_at, :content, :editing_body_id,
          :store_snapshot_to_version, snapshot_attributes: [ :title, :posted_at ],
          body_attributes: [ :id, :content, attachments_attributes: [ :id, :file, :_destroy ] ]
        ) if params[:article]
  end

  def article_body_params
    params.require(:article_body).permit(
          :id, :content, attachments_attributes: [ :id, :file, :_destroy ]
        ) if params[:article_body]
  end

  def value_to_boolean(value)
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end

  def find_collection
    if params[:collation_id] == "inbox"
      @collection = current_user.inbox
    end

    if params[:list_id]
      @collection = current_user.lists.find(params[:list_id])
    end
  end
  
end
