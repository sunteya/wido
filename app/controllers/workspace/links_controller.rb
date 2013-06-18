class Workspace::LinksController < Workspace::BaseController
  before_filter :find_collection

  def index
    redirect_to workspace_root_path
  end
  
  def show
    @link = @collection.links.find(params[:id])
  end

  def new
    @link = @collection.links.scoped.new
  end

  def create
    @link = @collection.links.scoped.new(link_params)

    if @link.save
      flash[:notice] = 'Link was successfully created.'
      redirect_to workspace_links_path
    else
      render "new"
    end
  end

  def edit
    @link = @collection.links.find(params[:id])
  end

  def update
    @link = @collection.links.find(params[:id])

    if @link.update_attributes(link_params)
      flash[notice] = 'Link was successfully updated.'
      redirect_to workspace_link_path(@link)
    else
      render "edit"
    end
  end

  def destroy
    @link = @collection.links.find(params[:id])
    @link.destroy

    redirect_to workspace_links_path
  end
  
  # def bookmarklet
    
  # end

  
protected
  def link_params
    params.require(:link).permit(:title, :url, :tag_list)
  end

  def find_collection
    # if params[:collection] == "index"
    @collection = current_user.inbox
    # end
  end
  
end
