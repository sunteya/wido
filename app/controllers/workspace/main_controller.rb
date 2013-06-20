class Workspace::MainController < Workspace::BaseController
  
  def root
    redirect_to workspace_inbox_path
  end
  
  def inbox
    @list = current_user.inbox
  end
  
end
