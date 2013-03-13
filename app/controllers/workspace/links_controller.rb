class Workspace::LinksController < Workspace::BaseController
  skip_before_filter :verify_authenticity_token
  
  def index
    @links = current_user.links.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end
  
  def show
    @link = current_user.links.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  def new
    @link = current_user.links.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  def edit
    @link = current_user.links.find(params[:id])
  end

  def create
    @list = current_user.inbox
    @link = @list.links.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to [ :workspace, @link ], notice: 'Link was successfully created.' }
        format.json { render json: @link, status: :created, location: [ :workspace, @link ] }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @link = current_user.links.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(link_params)
        format.html { redirect_to [ :workspace, @link ], notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link = current_user.links.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to workspace_links_url }
      format.json { head :no_content }
    end
  end
  
  def bookmarklet
    
  end

  
protected
  def link_params
    params.require(:link).permit(:title, :url)
  end
  
end
