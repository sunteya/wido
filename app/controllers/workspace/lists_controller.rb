class Workspace::ListsController < Workspace::BaseController

  def show
    @list = current_user.lists.find(params[:id])
    @collection = @list
  end

  def new
    @list = current_user.lists.scoped.new
    render layout: !request.xhr?
  end

  def create
    @list = current_user.lists.scoped.new(list_params)

    if @list.save
      render json: { location: workspace_list_path(@list) }
    else
      render json: { html: render_to_string(partial: "modal_form.html.erb") }, status: :unprocessable_entity
    end
  end

  def edit
    @list = current_user.lists.find(params[:id])
    render layout: !request.xhr?
  end

  def update
    @list = current_user.lists.find(params[:id])
    if @list.update_attributes(list_params)
      render json: { location: workspace_list_path(@list) }
    else
      render json: { html: render_to_string(partial: "modal_form.html.erb") }, status: :unprocessable_entity
    end
  end

  def delete
    @list = current_user.lists.find(params[:id])
    render layout: !request.xhr?
  end

  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy
    render json: { location: workspace_root_path }
  end

protected
  def list_params
    params.require(:list).permit(:name)
  end
end
