class MainController < ApplicationController
  def root
    redirect_to workspace_root_path
  end
end
