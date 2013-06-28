class Workspace::LinksController < Workspace::BaseController
  before_filter :find_collection

  # before_filter :allow_cross_domain_access, only: :create
  skip_before_filter :verify_authenticity_token, only: :create

  def index
    redirect_to collection_route(@collection).root_path
  end
  
  def show
    @link = @collection.links.find(params[:id])
  end

  def new
    @link = @collection.links.scoped.new(link_params)
  end

  def create
    @link = @collection.links.scoped.new(link_params)

    respond_to do |format|
      if @link.save
        format.html {
          flash[:notice] = 'Link was successfully created.'
          redirect_to workspace_links_path
        }

        format.json {
          render json: @link, status: :created, location: collection_route(@collection).link_path(@link)
        }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @link = @collection.links.find(params[:id])
  end

  def update
    @link = @collection.links.find(params[:id])

    if @link.update_attributes(link_params)
      flash[notice] = 'Link was successfully updated.'

      if @collection != @link.collection
        redirect_to collection_route(@collection).links_path
      else
        redirect_to collection_route(@collection).link_path(@link)
      end
    else
      render "edit"
    end
  end

  def destroy
    @link = @collection.links.find(params[:id])
    @link.destroy

    redirect_to collection_route(@collection).root_path
  end
  
protected
  def link_params
    params.require(:link).permit(:title, :url, :tag_list, :list_id)
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
