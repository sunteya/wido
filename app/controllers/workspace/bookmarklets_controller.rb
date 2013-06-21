class Workspace::BookmarkletsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :bookmarklet
  
  def add_link
  end
end
