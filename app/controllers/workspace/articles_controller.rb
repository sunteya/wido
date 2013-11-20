class Workspace::ArticlesController < Workspace::BaseController
  before_filter :find_collection

  def index
    redirect_to collection_route(@collection).root_path
  end
  
  def show
    @article = @collection.articles.find(params[:id])
  end

  def new
    @article = @collection.articles.scoped.new(article_params)
  end

  def create
    @article = @collection.articles.scoped.new(article_params)

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        redirect_to collection_route(@collection).article_path(@article)
      else
        render action: "new"
      end
    end
  end

  def edit
    @article = @collection.articles.find(params[:id])
  end

  def update
    @article = @collection.articles.find(params[:id])

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
    params.require(:article).permit(:title, :slug, :tag_list, :list_id, :content, attachments_attributes: [ :id, :file, :_destroy ]) if params[:article]
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
