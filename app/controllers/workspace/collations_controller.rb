class Workspace::CollationsController < Workspace::BaseController
  def show
    @collation = current_user.inbox
    @collection = @collation
  end
end
