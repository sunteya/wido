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
      redirect_to collection_route(@collection).link_path(@link)
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
    params.require(:link).permit(:title, :url, :tag_list)
  end

  def find_collection
    if params[:collation_id] == "inbox"
      @collection = current_user.inbox
    end
  end

  # def allow_cross_domain_access
  #   response.headers["Access-Control-Allow-Origin"] = "*"
  #   response.headers["Access-Control-Allow-Methods"] = "POST"
  #   # response.headers["Access-Control-Allow-Headers"] = "Content-Type, X-Requested-With"
  # end
  
end
