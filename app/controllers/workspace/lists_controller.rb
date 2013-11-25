class Workspace::ListsController < Workspace::BaseController
  def new
    @list = current_user.lists.scoped.new
    render layout: !request.xhr?
  end

  def create
    @list = current_user.lists.scoped.new(list_params)

    if @list.save
      redirect_to workspace_list_path(@list)
    else
      render 'new', status: :unprocessable_entity, layout: !request.xhr?
    end
  end

  def show
    @list = current_user.lists.find(params[:id])
    @collation = @list
  end

protected
  def list_params
    params.require(:list).permit(:name)
  end
end
