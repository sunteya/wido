class Collation
  attr_accessor :user, :id

  def links
    user.lists.where(syscode: id).first_or_create.links
  end

  def to_route(view)
    CollationRoute.new(view, self)
  end

  class CollationRoute
    attr_accessor :view, :collation

    def initialize(view, collation)
      self.view = view
      self.collation = collation
    end

    def root_path
      view.workspace_collation_path(collation.id)
    end
    
    def link_path(link)
      view.workspace_collation_link_path(collation.id, link)
    end

    def links_path
      view.workspace_collation_links_path(collation.id)
    end

    def edit_link_path(link)
      view.edit_workspace_collation_link_path(collation.id, link)
    end
  end
end