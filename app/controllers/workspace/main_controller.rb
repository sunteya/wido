class Workspace::MainController < Workspace::BaseController
  
  def root
    redirect_to workspace_collation_path('inbox')
  end
  
end
