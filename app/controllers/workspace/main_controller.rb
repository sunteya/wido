class Workspace::MainController < Workspace::BaseController
  
  
  
  def inbox
    @list = current_user.inbox
  end
  
end
